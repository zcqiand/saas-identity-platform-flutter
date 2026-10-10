#!/bin/sh
# Usage: saas-identity-platform-flutter.sh <DOCKER_USERNAME> <DOCKER_PASSWORD> [VERSION]
#
# 由 .github/workflows/ci.yml 的 deploy job 远程调用:
#   ssh deploy@vps -- cd /home/deploy/saas-identity-platform-flutter
#                    && sh saas-identity-platform-flutter.sh $DOCKER_USERNAME $DOCKER_PASSWORD $VERSION
#
# VERSION 默认是 latest。tag-based deploy 时显式传 tag 名（v0.x.y-YYYYMMDD）。
# CI 同时 push :latest + :<tag> 两份镜像,回滚只要手动指定旧 tag 再跑一次本脚本。
#
# 与母本 saas-identity-platform-react.sh 的差异:
#   - 同为静态 SPA：runtime 无 env 注入,**不**mount --env-file, **无** bootstrap/append 段
#   - 本仓无任何 app secret（连 LLM_API_KEY 都没有）,只校验 docker hub 凭据入参
#   - 模板 curl 加 ?v=$(date +%s) cache-buster —— raw.githubusercontent master 路径
#     走 CDN,推后 ~5min 内可能供旧内容(raw-githubusercontent-master-cdn-cache-delay 指纹)
#   - 健康检查 = 容器 State.Health 循环 + host 级 wget 探 `/` 双条
#
# 前置: deploy 用户需在 docker 组中(sudo usermod -aG docker deploy);
#        sudoers 放 nginx + systemctl reload + !requiretty(家族 cutover 已配)。

set -eu

USERNAME="${1:-}"
PASSWORD="${2:-}"
VERSION="${3:-latest}"
IMAGE="${USERNAME}/saas-identity-platform-flutter:${VERSION}"
BASE="/home/deploy/saas-identity-platform-flutter"
CONTAINER_NAME="saas-identity-platform-flutter"
# saas-flutter:容器内 nginx:alpine 监听 :80(privileged),host 端口走 family 段 5108(ADR-0018;
# X08 扩展槽位 2026-10-10 启用,此前 5108 仅 dev origin 用)
HOST_PORT=5108

# nginx domain(纯静态 SPA 无 runtime env,但 deploy 自举 nginx vhost 要用)
NGINX_DOMAIN="${NGINX_DOMAIN:-saas-flutter.xiangru.uk}"
NGINX_CERT_BASENAME="${NGINX_CERT_BASENAME:-xiangru-uk}"

if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
  echo "Usage: $0 <DOCKER_USERNAME> <DOCKER_PASSWORD> [VERSION]" >&2
  exit 2
fi

# nginx vhost 重渲染（每次 deploy 都跑,ADR-0018:容器端口变了 vhost 必须跟）:
# 模板从 master 拉,渲染后写入 sites-available,symlink sites-enabled,再 sudo nginx -t + reload。
# diff 检测:内容未变跳过 reload (nginx -t 也省)。
NGINX_SITES_AVAILABLE="/etc/nginx/sites-available"
NGINX_SITES_ENABLED="/etc/nginx/sites-enabled"
NGINX_VHOST_FILE="${NGINX_SITES_AVAILABLE}/${NGINX_DOMAIN}"
NGINX_VHOST_LINK="${NGINX_SITES_ENABLED}/${NGINX_DOMAIN}"
NGINX_TEMPLATE="${BASE}/nginx-vps.conf.example"

# 拉模板:每次都从 master 拉最新 —— VPS 本地老模板会渲染出老端口全家族 502
# (2026-09-03 事故纪律);?v= 时间戳破 raw CDN ~5min 陈旧窗口,set -eu 下 curl 失败即 fail-fast
echo "→ fetching nginx-vps.conf.example template (always fresh from master)"
curl -fsSL "https://raw.githubusercontent.com/zcqiand/saas-identity-platform-flutter/refs/heads/master/deploy/nginx-vps.conf.example?v=$(date +%s)" -o "${NGINX_TEMPLATE}"

# 渲染到临时文件 —— sed 同时覆盖 3 种 placeholder:
#   Style A:  <domain>
#   Style B/C: lab.YOUR_DOMAIN / saas.YOUR_DOMAIN
#   cert 路径: your-cert.{crt,cert} / <domain>.crt → 统一到 ${NGINX_CERT_BASENAME}.cert
TMP_VHOST="$(mktemp -t vpstpl.XXXXXX)"
# cert 归一化规则必须排在 <domain>/YOUR_DOMAIN 通配之前:sed -e 按顺序执行,
# 先替换 <domain> 会把 cert 路径里的占位符一并吃掉,后面的 cert 规则全部失配
# (2026-09-03 VPS nginx -t "cannot load certificate" 事故根因)
sed \
  -e "s|/etc/nginx/ssl/<domain>\.crt|/etc/nginx/ssl/${NGINX_CERT_BASENAME}.cert|g" \
  -e "s|/etc/nginx/ssl/<domain>\.cert|/etc/nginx/ssl/${NGINX_CERT_BASENAME}.cert|g" \
  -e "s|/etc/nginx/ssl/<domain>\.key|/etc/nginx/ssl/${NGINX_CERT_BASENAME}.key|g" \
  -e "s|/etc/nginx/ssl/your-cert\.crt|/etc/nginx/ssl/${NGINX_CERT_BASENAME}.cert|g" \
  -e "s|/etc/nginx/ssl/your-cert\.cert|/etc/nginx/ssl/${NGINX_CERT_BASENAME}.cert|g" \
  -e "s|/etc/nginx/ssl/your-cert\.key|/etc/nginx/ssl/${NGINX_CERT_BASENAME}.key|g" \
  -e "s|<domain>|${NGINX_DOMAIN}|g" \
  -e "s|lab\.YOUR_DOMAIN|${NGINX_DOMAIN}|g" \
  -e "s|saas\.YOUR_DOMAIN|${NGINX_DOMAIN}|g" \
  "${NGINX_TEMPLATE}" > "${TMP_VHOST}"

# diff 检测:已有 vhost 且内容相同就 skip,不同才重写 + reload
if [ -e "${NGINX_VHOST_FILE}" ] && diff -q "${TMP_VHOST}" "${NGINX_VHOST_FILE}" >/dev/null 2>&1; then
  echo "→ nginx vhost ${NGINX_VHOST_FILE} unchanged, skip"
  rm -f "${TMP_VHOST}"
else
  echo "→ rendering nginx vhost ${NGINX_VHOST_FILE} (domain=${NGINX_DOMAIN} cert=${NGINX_CERT_BASENAME})"
  # 写入 sites-available (deploy 用户可能没写权限,需要 sudoers 配 nginx 白名单)
  if [ -w "${NGINX_SITES_AVAILABLE}" ]; then
    cp "${TMP_VHOST}" "${NGINX_VHOST_FILE}"
  else
    sudo cp "${TMP_VHOST}" "${NGINX_VHOST_FILE}" \
      || { echo "ERROR: sudo cp ${NGINX_VHOST_FILE} failed"; rm -f "${TMP_VHOST}"; exit 1; }
  fi
  # symlink sites-enabled
  if [ -w "${NGINX_SITES_ENABLED}" ]; then
    ln -sf "${NGINX_VHOST_FILE}" "${NGINX_VHOST_LINK}"
  else
    sudo ln -sf "${NGINX_VHOST_FILE}" "${NGINX_VHOST_LINK}" \
      || { echo "ERROR: sudo ln ${NGINX_VHOST_LINK} failed"; rm -f "${TMP_VHOST}"; exit 1; }
  fi
  rm -f "${TMP_VHOST}"
  # nginx config test + reload (CI 自动完成,不再依赖手工)
  echo "→ nginx -t"
  sudo nginx -t
  echo "→ systemctl reload nginx"
  sudo systemctl reload nginx
  echo "✓ nginx reloaded"
fi

echo "→ image: $IMAGE"
echo "→ docker login"
printf '%s' "$PASSWORD" | docker login -u "$USERNAME" --password-stdin

echo "→ docker pull"
docker pull "$IMAGE"

echo "→ docker stop & rm $CONTAINER_NAME"
docker stop "$CONTAINER_NAME" 2>/dev/null || true
docker rm "$CONTAINER_NAME" 2>/dev/null || true

echo "→ docker run"
# Flutter Web 静态 SPA —— runtime 无 env-file 注入（dart-define 在 build 时已烤进 bundle）。
docker run -d \
  --name "$CONTAINER_NAME" \
  --restart unless-stopped \
  -p "127.0.0.1:${HOST_PORT}:80" \
  "$IMAGE"

echo "→ docker image prune"
docker image prune -f

echo "→ docker ps"
docker ps --filter name="$CONTAINER_NAME"

# 健康检查: 容器 healthcheck 30s 内应 healthy (Dockerfile: nginx:alpine + wget 127.0.0.1)
echo "→ waiting for container health..."
i=0
while [ $i -lt 30 ]; do
  STATUS=$(docker inspect --format='{{.State.Health.Status}}' "$CONTAINER_NAME" 2>/dev/null || echo "starting")
  if [ "$STATUS" = "healthy" ]; then
    echo "→ container healthy after ${i}s"
    break
  fi
  if [ "$STATUS" = "unhealthy" ]; then
    echo "→ container unhealthy, logs:"
    docker logs --tail 30 "$CONTAINER_NAME"
    exit 1
  fi
  i=$((i+1))
  sleep 1
done

if [ $i -ge 30 ]; then
  echo "→ container failed to become healthy in 30s, logs:"
  docker logs --tail 30 "$CONTAINER_NAME"
  exit 1
fi

# host 级探活（第二条）:探 `/` —— SPA fallback try_files 保证恒 200;
# 本仓无 /api/health,静态 200 也证不了 dart-define 烘焙(那是 Dockerfile grep 断言的职责),
# 这里只证「端口映射 + nginx serve」这一层。地址一律 127.0.0.1 字面量(busybox wget ::1 指纹)。
echo "→ host probe http://127.0.0.1:${HOST_PORT}/"
wget --tries=1 --timeout=3 -q "http://127.0.0.1:${HOST_PORT}/" -O /dev/null \
  || { echo "ERROR: host probe ${HOST_PORT} failed"; docker logs --tail 30 "$CONTAINER_NAME"; exit 1; }

echo "→ deploy done at $(date -u)"
