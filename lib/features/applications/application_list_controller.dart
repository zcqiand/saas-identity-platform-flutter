import 'package:built_collection/built_collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'app_providers.dart';

/// 应用列表状态机（role_list_controller 同构）：sealed 四态。
sealed class ApplicationListState {
  const ApplicationListState();
}

class ApplicationListLoading extends ApplicationListState {
  const ApplicationListLoading();
}

class ApplicationListLoaded extends ApplicationListState {
  const ApplicationListLoaded({required this.items});

  final BuiltList<TenantApplication> items;
}

class ApplicationListEmpty extends ApplicationListState {
  const ApplicationListEmpty();
}

class ApplicationListError extends ApplicationListState {
  const ApplicationListError(this.message);

  final String message;
}

/// 应用列表控制器：tenant-scoped（family by tenantId）；订阅行全量拉取
/// （契约无分页参数面，响应带 page/pageSize 仅形状）。
class ApplicationListController extends Notifier<ApplicationListState> {
  ApplicationListController(this.tenantId);

  final String tenantId;

  @override
  ApplicationListState build() => const ApplicationListLoading();

  Future<void> load({bool silent = false}) async {
    if (!silent) state = const ApplicationListLoading();
    try {
      final resp = await ref
          .read(tenantApplicationsApiProvider)
          .tenantApplicationsListTenantApplications(tenantId: tenantId);
      final items = resp.data!.items;
      state = items.isEmpty
          ? const ApplicationListEmpty()
          : ApplicationListLoaded(items: items);
    } on Exception {
      state = const ApplicationListError('无法连接服务器');
    }
  }

  /// 行内启停（M00.F05.I03）：PUT body 恰 status（expireTime 不随）。
  /// 成功后以回包原位替换该行——列表回刷走的是旧 GET 快照，徽标必须
  /// 取权威回包而非回刷。返回是否成功（页侧凭此决定是否提示）。
  Future<bool> setStatus(TenantApplication app, int status) async {
    try {
      final resp = await ref
          .read(tenantApplicationsApiProvider)
          .tenantApplicationsUpdateTenantApplication(
            tenantId: tenantId,
            clientId: app.clientId,
            updateTenantApplicationRequest: UpdateTenantApplicationRequest(
              (b) => b..status = status,
            ),
          );
      final current = state;
      if (current is ApplicationListLoaded) {
        final idx = current.items.indexWhere((e) => e.clientId == app.clientId);
        if (idx >= 0) {
          state = ApplicationListLoaded(
            items: current.items.rebuild((b) => b[idx] = resp.data!),
          );
        }
      }
      return true;
    } on Exception {
      return false;
    }
  }
}

final applicationListControllerProvider = NotifierProvider.autoDispose
    .family<ApplicationListController, ApplicationListState, String>(
      ApplicationListController.new,
    );
