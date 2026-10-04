//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:saas_identity_platform_flutter/generated/serializers.dart';
import 'package:saas_identity_platform_flutter/generated/auth/api_key_auth.dart';
import 'package:saas_identity_platform_flutter/generated/auth/basic_auth.dart';
import 'package:saas_identity_platform_flutter/generated/auth/bearer_auth.dart';
import 'package:saas_identity_platform_flutter/generated/auth/oauth.dart';
import 'package:saas_identity_platform_flutter/generated/api/admin_clients_api.dart';
import 'package:saas_identity_platform_flutter/generated/api/admin_tenants_api.dart';
import 'package:saas_identity_platform_flutter/generated/api/auth_api.dart';
import 'package:saas_identity_platform_flutter/generated/api/client_menus_api.dart';
import 'package:saas_identity_platform_flutter/generated/api/clients_api.dart';
import 'package:saas_identity_platform_flutter/generated/api/me_api.dart';
import 'package:saas_identity_platform_flutter/generated/api/oauth_api.dart';
import 'package:saas_identity_platform_flutter/generated/api/tenant_applications_api.dart';
import 'package:saas_identity_platform_flutter/generated/api/tenant_members_api.dart';
import 'package:saas_identity_platform_flutter/generated/api/tenant_role_menus_api.dart';
import 'package:saas_identity_platform_flutter/generated/api/tenant_roles_api.dart';

class SaasSharedGenerated {
  static const String basePath = r'https://api.example.com';

  final Dio dio;
  final Serializers serializers;

  SaasSharedGenerated({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  }) : this.serializers = serializers ?? standardSerializers,
       this.dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: basePathOverride ?? basePath,
               connectTimeout: const Duration(milliseconds: 5000),
               receiveTimeout: const Duration(milliseconds: 3000),
             ),
           ) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere(
        (i) => i is OAuthInterceptor,
      ) as OAuthInterceptor).tokens[name] = token;
    }
  }

  /// Removes the OAuth token associated with the given [name].
  ///
  /// If no [OAuthInterceptor] is registered or no token exists for the given
  /// [name], this method has no effect.
  void removeOAuthToken(String name) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere(
        (i) => i is OAuthInterceptor,
      ) as OAuthInterceptor).tokens.remove(name);
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere(
        (i) => i is BearerAuthInterceptor,
      ) as BearerAuthInterceptor).tokens[name] = token;
    }
  }

  /// Removes the bearer authentication token associated with the given [name].
  ///
  /// If no [BearerAuthInterceptor] is registered or no token exists for the
  /// given [name], this method has no effect.
  void removeBearerAuth(String name) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere(
        (i) => i is BearerAuthInterceptor,
      ) as BearerAuthInterceptor).tokens.remove(name);
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere(
        (i) => i is BasicAuthInterceptor,
      ) as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(
        username,
        password,
      );
    }
  }

  /// Removes the basic authentication credentials associated with the given [name].
  ///
  /// If no [BasicAuthInterceptor] is registered or no credentials exist for the
  /// given [name], this method has no effect.
  void removeBasicAuth(String name) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere(
        (i) => i is BasicAuthInterceptor,
      ) as BasicAuthInterceptor).authInfo.remove(name);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere(
        (element) => element is ApiKeyAuthInterceptor,
      ) as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }
  }

  /// Removes the API key associated with the given [name].
  ///
  /// If no [ApiKeyAuthInterceptor] is registered or no API key exists for the
  /// given [name], this method has no effect.
  void removeApiKey(String name) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere(
        (element) => element is ApiKeyAuthInterceptor,
      ) as ApiKeyAuthInterceptor).apiKeys.remove(name);
    }
  }

  /// Get AdminClientsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminClientsApi getAdminClientsApi() {
    return AdminClientsApi(dio, serializers);
  }

  /// Get AdminTenantsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminTenantsApi getAdminTenantsApi() {
    return AdminTenantsApi(dio, serializers);
  }

  /// Get AuthApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AuthApi getAuthApi() {
    return AuthApi(dio, serializers);
  }

  /// Get ClientMenusApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ClientMenusApi getClientMenusApi() {
    return ClientMenusApi(dio, serializers);
  }

  /// Get ClientsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ClientsApi getClientsApi() {
    return ClientsApi(dio, serializers);
  }

  /// Get MeApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MeApi getMeApi() {
    return MeApi(dio, serializers);
  }

  /// Get OauthApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  OauthApi getOauthApi() {
    return OauthApi(dio, serializers);
  }

  /// Get TenantApplicationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TenantApplicationsApi getTenantApplicationsApi() {
    return TenantApplicationsApi(dio, serializers);
  }

  /// Get TenantMembersApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TenantMembersApi getTenantMembersApi() {
    return TenantMembersApi(dio, serializers);
  }

  /// Get TenantRoleMenusApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TenantRoleMenusApi getTenantRoleMenusApi() {
    return TenantRoleMenusApi(dio, serializers);
  }

  /// Get TenantRolesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TenantRolesApi getTenantRolesApi() {
    return TenantRolesApi(dio, serializers);
  }
}
