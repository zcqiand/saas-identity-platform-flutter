//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:saas_identity_platform_flutter/generated/model/tenant_member_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tenant_members_change_tenant_user_status_request.g.dart';

/// TenantMembersChangeTenantUserStatusRequest
///
/// Properties:
/// * [status]
@BuiltValue()
abstract class TenantMembersChangeTenantUserStatusRequest
    implements
        Built<
          TenantMembersChangeTenantUserStatusRequest,
          TenantMembersChangeTenantUserStatusRequestBuilder
        > {
  @BuiltValueField(wireName: r'status')
  TenantMemberStatus get status;
  // enum statusEnum {  active,  invited,  suspended,  disabled,  };

  TenantMembersChangeTenantUserStatusRequest._();

  factory TenantMembersChangeTenantUserStatusRequest([
    void updates(TenantMembersChangeTenantUserStatusRequestBuilder b),
  ]) = _$TenantMembersChangeTenantUserStatusRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TenantMembersChangeTenantUserStatusRequestBuilder b) =>
      b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TenantMembersChangeTenantUserStatusRequest>
  get serializer => _$TenantMembersChangeTenantUserStatusRequestSerializer();
}

class _$TenantMembersChangeTenantUserStatusRequestSerializer
    implements PrimitiveSerializer<TenantMembersChangeTenantUserStatusRequest> {
  @override
  final Iterable<Type> types = const [
    TenantMembersChangeTenantUserStatusRequest,
    _$TenantMembersChangeTenantUserStatusRequest,
  ];

  @override
  final String wireName = r'TenantMembersChangeTenantUserStatusRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TenantMembersChangeTenantUserStatusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(TenantMemberStatus),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TenantMembersChangeTenantUserStatusRequest object, {
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
    required TenantMembersChangeTenantUserStatusRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TenantMemberStatus),
          ) as TenantMemberStatus;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TenantMembersChangeTenantUserStatusRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TenantMembersChangeTenantUserStatusRequestBuilder();
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
