// @entry M00.F02.I03
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'member_providers.dart';
import 'member_status_label.dart';

/// 成员详情（M00.F02.I03）：GET /members/{userId} 八字段卡
/// （id/tenantId/username/email/status/roleIds/createdAt/updatedAt——
/// TenantMemberUserView 恰此八，禁超面）。
class MemberDetailPage extends ConsumerStatefulWidget {
  const MemberDetailPage({
    super.key,
    required this.tenantId,
    required this.userId,
  });

  final String tenantId;
  final String userId;

  @override
  ConsumerState<MemberDetailPage> createState() => _MemberDetailPageState();
}

class _MemberDetailPageState extends ConsumerState<MemberDetailPage> {
  TenantMemberUserView? _member;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final response = await ref
          .read(tenantMembersApiProvider)
          .tenantMembersGetTenantUser(
            tenantId: widget.tenantId,
            userId: widget.userId,
          );
      if (!mounted) return;
      setState(() => _member = response.data);
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.response == null ? '无法连接服务器' : '加载失败，请重试');
    }
  }

  @override
  Widget build(BuildContext context) {
    final m = _member;
    return Scaffold(
      appBar: AppBar(title: Text(m?.username ?? '成员详情')),
      body: m == null
          ? Center(
              child: _error == null
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_error!),
                        const SizedBox(height: 8),
                        FilledButton(onPressed: _load, child: const Text('重试')),
                      ],
                    ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _row('ID', m.id),
                _row('租户', m.tenantId),
                _row('用户名', m.username),
                _row('邮箱', m.email ?? '—'),
                _row('状态', memberStatusLabel(m.status)),
                _row('角色', m.roleIds.isEmpty ? '—' : m.roleIds.join('、')),
                _row('创建时间', _fmt(m.createdAt)),
                _row('更新时间', _fmt(m.updatedAt)),
              ],
            ),
    );
  }

  String _fmt(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 88,
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
