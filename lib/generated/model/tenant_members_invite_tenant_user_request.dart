//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tenant_members_invite_tenant_user_request.g.dart';

/// TenantMembersInviteTenantUserRequest
///
/// Properties:
/// * [email]
/// * [mobile]
@BuiltValue()
abstract class TenantMembersInviteTenantUserRequest
    implements
        Built<
          TenantMembersInviteTenantUserRequest,
          TenantMembersInviteTenantUserRequestBuilder
        > {
  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'mobile')
  String? get mobile;

  TenantMembersInviteTenantUserRequest._();

  factory TenantMembersInviteTenantUserRequest([
    void updates(TenantMembersInviteTenantUserRequestBuilder b),
  ]) = _$TenantMembersInviteTenantUserRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TenantMembersInviteTenantUserRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TenantMembersInviteTenantUserRequest> get serializer =>
      _$TenantMembersInviteTenantUserRequestSerializer();
}

class _$TenantMembersInviteTenantUserRequestSerializer
    implements PrimitiveSerializer<TenantMembersInviteTenantUserRequest> {
  @override
  final Iterable<Type> types = const [
    TenantMembersInviteTenantUserRequest,
    _$TenantMembersInviteTenantUserRequest,
  ];

  @override
  final String wireName = r'TenantMembersInviteTenantUserRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TenantMembersInviteTenantUserRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
    if (object.mobile != null) {
      yield r'mobile';
      yield serializers.serialize(
        object.mobile,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TenantMembersInviteTenantUserRequest object, {
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
    required TenantMembersInviteTenantUserRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'mobile':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.mobile = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TenantMembersInviteTenantUserRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TenantMembersInviteTenantUserRequestBuilder();
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
