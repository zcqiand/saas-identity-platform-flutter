import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'tenant_providers.dart';

/// 租户详情状态机（M00.F01.I03，lab receipt_detail_controller 同构：
/// 普通 autoDispose + load(tenantId:) 显式带 id，_currentId 防陈旧响应）。
sealed class TenantDetailState {
  const TenantDetailState();
}

class TenantDetailLoading extends TenantDetailState {
  const TenantDetailLoading();
}

class TenantDetailLoaded extends TenantDetailState {
  const TenantDetailLoaded({required this.tenant});
  final Tenant tenant;
}

class TenantDetailError extends TenantDetailState {
  const TenantDetailError({required this.message});
  final String message;
}

class TenantDetailController extends Notifier<TenantDetailState> {
  late final AdminTenantsApi _api;
  String? _currentId;

  @override
  TenantDetailState build() {
    _api = ref.watch(adminTenantsApiProvider);
    return const TenantDetailLoading();
  }

  /// 详情按路由参数 id 拉 GET /{id}（Review Focus 3：不透传列表行对象，
  /// 身份一致由请求 path 保证）。_currentId 双保险：pop 后陈旧响应丢弃。
  Future<void> load({required String tenantId}) async {
    _currentId = tenantId;
    state = const TenantDetailLoading();
    try {
      final response = await _api.adminTenantsGetTenant(id: tenantId);
      if (!ref.mounted || _currentId != tenantId) return;
      state = TenantDetailLoaded(tenant: response.data!);
    } on DioException catch (e) {
      if (!ref.mounted || _currentId != tenantId) return;
      state = TenantDetailError(message: _mapError(e));
    }
  }

  String _mapError(DioException e) {
    if (e.response == null) return '无法连接服务器';
    return '加载失败，请重试';
  }
}

/// autoDispose（lab 详情同口径：详情 t-1 → 返回 → t-2 不再首帧闪旧数据）。
final tenantDetailControllerProvider =
    NotifierProvider.autoDispose<TenantDetailController, TenantDetailState>(
      TenantDetailController.new,
    );
