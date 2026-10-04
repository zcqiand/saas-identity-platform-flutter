//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:saas_identity_platform_flutter/generated/api_util.dart';
import 'package:saas_identity_platform_flutter/generated/model/create_sys_role_request.dart';
import 'package:saas_identity_platform_flutter/generated/model/error_response.dart';
import 'package:saas_identity_platform_flutter/generated/model/sys_role.dart';
import 'package:saas_identity_platform_flutter/generated/model/tenant_roles_list_sys_roles200_response.dart';
import 'package:saas_identity_platform_flutter/generated/model/update_sys_role_request.dart';

class TenantRolesApi {
  final Dio _dio;

  final Serializers _serializers;

  const TenantRolesApi(this._dio, this._serializers);

  /// tenantRolesCreateSysRole
  ///
  ///
  /// Parameters:
  /// * [tenantId]
  /// * [createSysRoleRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [SysRole] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<SysRole>> tenantRolesCreateSysRole({
    required String tenantId,
    required CreateSysRoleRequest createSysRoleRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/tenants/{tenantId}/roles'.replaceAll(
      '{'
      r'tenantId'
      '}',
      encodeQueryParameter(
        _serializers,
        tenantId,
        const FullType(String),
      ).toString(),
    );
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(CreateSysRoleRequest);
      _bodyData = _serializers.serialize(
        createSysRoleRequest,
        specifiedType: _type,
      );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _options.compose(_dio.options, _path),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    SysRole? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
              rawResponse,
              specifiedType: const FullType(SysRole),
            ) as SysRole;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<SysRole>(
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

  /// tenantRolesDeleteSysRole
  ///
  ///
  /// Parameters:
  /// * [tenantId]
  /// * [roleId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> tenantRolesDeleteSysRole({
    required String tenantId,
    required String roleId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/tenants/{tenantId}/roles/{roleId}'
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

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }

  /// tenantRolesGetSysRole
  ///
  ///
  /// Parameters:
  /// * [tenantId]
  /// * [roleId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [SysRole] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<SysRole>> tenantRolesGetSysRole({
    required String tenantId,
    required String roleId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/tenants/{tenantId}/roles/{roleId}'
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

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    SysRole? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
              rawResponse,
              specifiedType: const FullType(SysRole),
            ) as SysRole;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<SysRole>(
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

  /// tenantRolesListSysRoles
  ///
  ///
  /// Parameters:
  /// * [tenantId]
  /// * [clientId]
  /// * [page]
  /// * [pageSize]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [TenantRolesListSysRoles200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<TenantRolesListSysRoles200Response>> tenantRolesListSysRoles({
    required String tenantId,
    String? clientId,
    int? page,
    int? pageSize,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/tenants/{tenantId}/roles'.replaceAll(
      '{'
      r'tenantId'
      '}',
      encodeQueryParameter(
        _serializers,
        tenantId,
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
      if (page != null)
        r'page': encodeQueryParameter(_serializers, page, const FullType(int)),
      if (pageSize != null)
        r'pageSize': encodeQueryParameter(
          _serializers,
          pageSize,
          const FullType(int),
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

    TenantRolesListSysRoles200Response? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
              rawResponse,
              specifiedType: const FullType(TenantRolesListSysRoles200Response),
            ) as TenantRolesListSysRoles200Response;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<TenantRolesListSysRoles200Response>(
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

  /// tenantRolesUpdateSysRole
  ///
  ///
  /// Parameters:
  /// * [tenantId]
  /// * [roleId]
  /// * [updateSysRoleRequest]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [SysRole] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<SysRole>> tenantRolesUpdateSysRole({
    required String tenantId,
    required String roleId,
    required UpdateSysRoleRequest updateSysRoleRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/tenants/{tenantId}/roles/{roleId}'
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
      method: r'PATCH',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{'secure': <Map<String, String>>[], ...?extra},
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(UpdateSysRoleRequest);
      _bodyData = _serializers.serialize(
        updateSysRoleRequest,
        specifiedType: _type,
      );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _options.compose(_dio.options, _path),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    SysRole? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
              rawResponse,
              specifiedType: const FullType(SysRole),
            ) as SysRole;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<SysRole>(
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
