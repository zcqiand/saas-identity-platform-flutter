//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:saas_identity_platform_flutter/generated/model/tenant_member_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tenant_membership.g.dart';

/// TenantMembership
///
/// Properties:
/// * [id]
/// * [userId]
/// * [tenantId]
/// * [roleIds]
/// * [status]
/// * [joinedAt]
@BuiltValue()
abstract class TenantMembership
    implements Built<TenantMembership, TenantMembershipBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'userId')
  String get userId;

  @BuiltValueField(wireName: r'tenantId')
  String get tenantId;

  @BuiltValueField(wireName: r'roleIds')
  BuiltList<String> get roleIds;

  @BuiltValueField(wireName: r'status')
  TenantMemberStatus get status;
  // enum statusEnum {  active,  invited,  suspended,  disabled,  };

  @BuiltValueField(wireName: r'joinedAt')
  DateTime get joinedAt;

  TenantMembership._();

  factory TenantMembership([void updates(TenantMembershipBuilder b)]) =
      _$TenantMembership;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TenantMembershipBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TenantMembership> get serializer =>
      _$TenantMembershipSerializer();
}

class _$TenantMembershipSerializer
    implements PrimitiveSerializer<TenantMembership> {
  @override
  final Iterable<Type> types = const [TenantMembership, _$TenantMembership];

  @override
  final String wireName = r'TenantMembership';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TenantMembership object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    yield r'tenantId';
    yield serializers.serialize(
      object.tenantId,
      specifiedType: const FullType(String),
    );
    yield r'roleIds';
    yield serializers.serialize(
      object.roleIds,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(TenantMemberStatus),
    );
    yield r'joinedAt';
    yield serializers.serialize(
      object.joinedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TenantMembership object, {
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
    required TenantMembershipBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'tenantId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tenantId = valueDes;
          break;
        case r'roleIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.roleIds.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TenantMemberStatus),
          ) as TenantMemberStatus;
          result.status = valueDes;
          break;
        case r'joinedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.joinedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TenantMembership deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TenantMembershipBuilder();
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
