//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_menu_grant.g.dart';

/// RoleMenuGrant
///
/// Properties:
/// * [roleId]
/// * [tenantId]
/// * [menuIds]
/// * [updatedAt]
@BuiltValue()
abstract class RoleMenuGrant
    implements Built<RoleMenuGrant, RoleMenuGrantBuilder> {
  @BuiltValueField(wireName: r'roleId')
  String get roleId;

  @BuiltValueField(wireName: r'tenantId')
  String get tenantId;

  @BuiltValueField(wireName: r'menuIds')
  BuiltList<String> get menuIds;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime get updatedAt;

  RoleMenuGrant._();

  factory RoleMenuGrant([void updates(RoleMenuGrantBuilder b)]) =
      _$RoleMenuGrant;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleMenuGrantBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleMenuGrant> get serializer =>
      _$RoleMenuGrantSerializer();
}

class _$RoleMenuGrantSerializer implements PrimitiveSerializer<RoleMenuGrant> {
  @override
  final Iterable<Type> types = const [RoleMenuGrant, _$RoleMenuGrant];

  @override
  final String wireName = r'RoleMenuGrant';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleMenuGrant object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'roleId';
    yield serializers.serialize(
      object.roleId,
      specifiedType: const FullType(String),
    );
    yield r'tenantId';
    yield serializers.serialize(
      object.tenantId,
      specifiedType: const FullType(String),
    );
    yield r'menuIds';
    yield serializers.serialize(
      object.menuIds,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'updatedAt';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleMenuGrant object, {
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
    required RoleMenuGrantBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'roleId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.roleId = valueDes;
          break;
        case r'tenantId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tenantId = valueDes;
          break;
        case r'menuIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.menuIds.replace(valueDes);
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RoleMenuGrant deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleMenuGrantBuilder();
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
