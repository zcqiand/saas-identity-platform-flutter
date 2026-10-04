//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:saas_identity_platform_flutter/generated/model/sys_user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:saas_identity_platform_flutter/generated/model/tenant_membership.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_response.g.dart';

/// LoginResponse
///
/// Properties:
/// * [user]
/// * [availableTenants]
/// * [userId]
/// * [currentTenantId]
/// * [accessToken]
/// * [refreshToken]
/// * [tokenType]
/// * [expiresIn]
/// * [clientId]
@BuiltValue()
abstract class LoginResponse
    implements Built<LoginResponse, LoginResponseBuilder> {
  @BuiltValueField(wireName: r'user')
  SysUser get user;

  @BuiltValueField(wireName: r'availableTenants')
  BuiltList<TenantMembership> get availableTenants;

  @BuiltValueField(wireName: r'userId')
  String get userId;

  @BuiltValueField(wireName: r'currentTenantId')
  String? get currentTenantId;

  @BuiltValueField(wireName: r'accessToken')
  String? get accessToken;

  @BuiltValueField(wireName: r'refreshToken')
  String? get refreshToken;

  @BuiltValueField(wireName: r'tokenType')
  String? get tokenType;

  @BuiltValueField(wireName: r'expiresIn')
  int? get expiresIn;

  @BuiltValueField(wireName: r'clientId')
  String get clientId;

  LoginResponse._();

  factory LoginResponse([void updates(LoginResponseBuilder b)]) =
      _$LoginResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginResponse> get serializer =>
      _$LoginResponseSerializer();
}

class _$LoginResponseSerializer implements PrimitiveSerializer<LoginResponse> {
  @override
  final Iterable<Type> types = const [LoginResponse, _$LoginResponse];

  @override
  final String wireName = r'LoginResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(SysUser),
    );
    yield r'availableTenants';
    yield serializers.serialize(
      object.availableTenants,
      specifiedType: const FullType(BuiltList, [FullType(TenantMembership)]),
    );
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    if (object.currentTenantId != null) {
      yield r'currentTenantId';
      yield serializers.serialize(
        object.currentTenantId,
        specifiedType: const FullType(String),
      );
    }
    if (object.accessToken != null) {
      yield r'accessToken';
      yield serializers.serialize(
        object.accessToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.refreshToken != null) {
      yield r'refreshToken';
      yield serializers.serialize(
        object.refreshToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.tokenType != null) {
      yield r'tokenType';
      yield serializers.serialize(
        object.tokenType,
        specifiedType: const FullType(String),
      );
    }
    if (object.expiresIn != null) {
      yield r'expiresIn';
      yield serializers.serialize(
        object.expiresIn,
        specifiedType: const FullType(int),
      );
    }
    yield r'clientId';
    yield serializers.serialize(
      object.clientId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(
      serializers,
      object,
      specifiedType: specifiedType,
    ).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SysUser),
          ) as SysUser;
          result.user.replace(valueDes);
          break;
        case r'availableTenants':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(TenantMembership),
            ]),
          ) as BuiltList<TenantMembership>;
          result.availableTenants.replace(valueDes);
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'currentTenantId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentTenantId = valueDes;
          break;
        case r'accessToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.accessToken = valueDes;
          break;
        case r'refreshToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.refreshToken = valueDes;
          break;
        case r'tokenType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.tokenType = valueDes;
          break;
        case r'expiresIn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.expiresIn = valueDes;
          break;
        case r'clientId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
