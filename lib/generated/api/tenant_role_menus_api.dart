//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:saas_identity_platform_flutter/generated/api_util.dart';
import 'package:saas_identity_platform_flutter/generated/model/error_response.dart';
import 'package:saas_identity_platform_flutter/generated/model/role_menu_grant.dart';
import 'package:saas_identity_platform_flutter/generated/model/set_sys_role_menus_request.dart';

class TenantRoleMenusApi {
  final Dio _dio;

  final Serializers _serializers;

  const TenantRoleMenusApi(this._dio, this._serializers);

  /// tenantRoleMenusClearSysRoleMenus
  ///
  ///
  /// Parameters:
  /// * [tenantId]
  /// * [roleId]
  /// * [clientId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> tenantRoleMenusClearSysRoleMenus({
    required String tenantId,
    required String roleId,
    String? clientId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/tenants/{tenantId}/roles/{roleId}/menus'
        .replaceAll(
          '{'
          r'tenantId'
          '}',
          encodeQueryParameter(
            _serializers,
            tenantId,
            const FullType(String),
          ).toString(),
        )
        .replaceAll(
          '{'
          r'roleId'
          '}',
          encodeQueryParameter(
            _serializers,
            roleId,
            const FullType(String),
          ).toString(),
        );
    final _options = Options(
      method: r'DELETE',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (clientId != null)
        r'clientId': encodeQueryParameter(
          _serializers,
          clientId,
          const FullType(String),
        ),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }

  /// tenantRoleMenusListSysRoleMenus
  ///
  ///
  /// Parameters:
  /// * [tenantId]
  /// * [roleId]
  /// * [clientId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [RoleMenuGrant] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<RoleMenuGrant>> tenantRoleMenusListSysRoleMenus({
    required String tenantId,
    required String roleId,
    String? clientId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/tenants/{tenantId}/roles/{roleId}/menus'
        .replaceAll(
          '{'
          r'tenantId'
          '}',
          encodeQueryParameter(
            _serializers,
            tenantId,
            const FullType(String),
          ).toString(),
        )
        .replaceAll(
          '{'
          r'roleId'
          '}',
          encodeQueryParameter(
            _serializers,
            roleId,
            const FullType(String),
          ).toString(),
        );
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (clientId != null)
        r'clientId': encodeQueryParameter(
          _serializers,
          clientId,
          const FullType(String),
        ),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    RoleMenuGrant? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
              rawResponse,
              specifiedType: const FullType(RoleMenuGrant),
            ) as RoleMenuGrant;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<RoleMenuGrant>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// tenantRoleMenusSetSysRoleMenus
  ///
  ///
  /// Parameters:
  /// * [tenantId]
  /// * [roleId]
  /// * [setSysRoleMenusRequest]
  /// * [clientId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [RoleMenuGrant] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<RoleMenuGrant>> tenantRoleMenusSetSysRoleMenus({
    required String tenantId,
    required String roleId,
    required SetSysRoleMenusRequest setSysRoleMenusRequest,
    String? clientId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/tenants/{tenantId}/roles/{roleId}/menus'
        .replaceAll(
          '{'
          r'tenantId'
          '}',
          encodeQueryParameter(
            _serializers,
            tenantId,
            const FullType(String),
          ).toString(),
        )
        .replaceAll(
          '{'
          r'roleId'
          '}',
          encodeQueryParameter(
            _serializers,
            roleId,
            const FullType(String),
          ).toString(),
        );
    final _options = Options(
      method: r'PUT',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (clientId != null)
        r'clientId': encodeQueryParameter(
          _serializers,
          clientId,
          const FullType(String),
        ),
    };

    dynamic _bodyData;

    try {
      const _type = FullType(SetSysRoleMenusRequest);
      _bodyData = _serializers.serialize(
        setSysRoleMenusRequest,
        specifiedType: _type,
      );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _options.compose(
          _dio.options,
          _path,
          queryParameters: _queryParameters,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    RoleMenuGrant? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
              rawResponse,
              specifiedType: const FullType(RoleMenuGrant),
            ) as RoleMenuGrant;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<RoleMenuGrant>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }
}
