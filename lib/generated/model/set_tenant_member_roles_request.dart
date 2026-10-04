//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_tenant_member_roles_request.g.dart';

/// SetTenantMemberRolesRequest
///
/// Properties:
/// * [roleIds]
@BuiltValue()
abstract class SetTenantMemberRolesRequest
    implements
        Built<SetTenantMemberRolesRequest, SetTenantMemberRolesRequestBuilder> {
  @BuiltValueField(wireName: r'roleIds')
  BuiltList<String> get roleIds;

  SetTenantMemberRolesRequest._();

  factory SetTenantMemberRolesRequest([
    void updates(SetTenantMemberRolesRequestBuilder b),
  ]) = _$SetTenantMemberRolesRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetTenantMemberRolesRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetTenantMemberRolesRequest> get serializer =>
      _$SetTenantMemberRolesRequestSerializer();
}

class _$SetTenantMemberRolesRequestSerializer
    implements PrimitiveSerializer<SetTenantMemberRolesRequest> {
  @override
  final Iterable<Type> types = const [
    SetTenantMemberRolesRequest,
    _$SetTenantMemberRolesRequest,
  ];

  @override
  final String wireName = r'SetTenantMemberRolesRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetTenantMemberRolesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'roleIds';
    yield serializers.serialize(
      object.roleIds,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SetTenantMemberRolesRequest object, {
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
    required SetTenantMemberRolesRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'roleIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.roleIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SetTenantMemberRolesRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetTenantMemberRolesRequestBuilder();
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
