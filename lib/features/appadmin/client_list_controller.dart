import 'package:built_collection/built_collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'app_admin_providers.dart';

/// 应用列表状态机（application_list_controller 同构）：sealed 四态。
sealed class ClientListState {
  const ClientListState();
}

class ClientListLoading extends ClientListState {
  const ClientListLoading();
}

class ClientListLoaded extends ClientListState {
  const ClientListLoaded({required this.items});

  final BuiltList<OAuthClient> items;
}

class ClientListEmpty extends ClientListState {
  const ClientListEmpty();
}

class ClientListError extends ClientListState {
  const ClientListError(this.message);

  final String message;
}

/// 平台 admin 应用列表控制器（M04.F01）：分页 list + 增删改 + 启停。
/// 写操作成功用响应回填（GET 重拉返旧快照坑，application_list_controller 同款）。
class ClientListController extends Notifier<ClientListState> {
  @override
  ClientListState build() => const ClientListLoading();

  Future<void> load({bool silent = false}) async {
    if (!silent) state = const ClientListLoading();
    try {
      final resp = await ref
          .read(adminClientsApiProvider)
          .adminClientsListClients();
      final items = resp.data!.items;
      state = items.isEmpty
          ? const ClientListEmpty()
          : ClientListLoaded(items: items);
    } on Exception {
      state = const ClientListError('无法连接服务器');
    }
  }

  /// 创建（M04.F01.I02）：密钥表单侧生成（sec- 前缀随机，nextjs 同款）。
  Future<bool> create(CreateOAuthClientRequest request) async {
    try {
      await ref
          .read(adminClientsApiProvider)
          .adminClientsCreateClient(createOAuthClientRequest: request);
      await load(silent: true);
      return true;
    } on Exception {
      return false;
    }
  }

  /// 更新（M04.F01.I04）：PUT 响应为权威快照，按 clientId 回填列表。
  Future<bool> update(String clientId, UpdateOAuthClientRequest request) async {
    try {
      final resp = await ref
          .read(adminClientsApiProvider)
          .adminClientsUpdateClient(
            clientId: clientId,
            updateOAuthClientRequest: request,
          );
      _replace(resp.data!);
      return true;
    } on Exception {
      return false;
    }
  }

  /// 启停（M04.F02.I01）：PUT status 响应回填，行内即时翻转。
  Future<bool> setStatus(OAuthClient client, int status) async {
    try {
      final resp = await ref
          .read(adminClientsApiProvider)
          .adminClientsSetClientStatus(
            clientId: client.clientId,
            adminClientsSetClientStatusRequest:
                AdminClientsSetClientStatusRequest((b) => b..status = status),
          );
      _replace(resp.data!);
      return true;
    } on Exception {
      return false;
    }
  }

  /// 删除（M04.F01.I05）：移除应用并吊销其名下全部 token（后端语义，
  /// 确认弹窗明示）；成功后静默回刷。
  Future<bool> remove(String clientId) async {
    try {
      await ref
          .read(adminClientsApiProvider)
          .adminClientsDeleteClient(clientId: clientId);
      await load(silent: true);
      return true;
    } on Exception {
      return false;
    }
  }

  void _replace(OAuthClient fresh) {
    final current = state;
    if (current is! ClientListLoaded) return;
    final idx = current.items.indexWhere((c) => c.clientId == fresh.clientId);
    if (idx < 0) return;
    state = ClientListLoaded(
      items: current.items.rebuild((b) => b[idx] = fresh),
    );
  }
}

final clientListControllerProvider =
    NotifierProvider.autoDispose<ClientListController, ClientListState>(
      ClientListController.new,
    );
