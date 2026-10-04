//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_sys_role_menus_request.g.dart';

/// SetSysRoleMenusRequest
///
/// Properties:
/// * [menuIds]
@BuiltValue()
abstract class SetSysRoleMenusRequest
    implements Built<SetSysRoleMenusRequest, SetSysRoleMenusRequestBuilder> {
  @BuiltValueField(wireName: r'menuIds')
  BuiltList<String> get menuIds;

  SetSysRoleMenusRequest._();

  factory SetSysRoleMenusRequest([
    void updates(SetSysRoleMenusRequestBuilder b),
  ]) = _$SetSysRoleMenusRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetSysRoleMenusRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetSysRoleMenusRequest> get serializer =>
      _$SetSysRoleMenusRequestSerializer();
}

class _$SetSysRoleMenusRequestSerializer
    implements PrimitiveSerializer<SetSysRoleMenusRequest> {
  @override
  final Iterable<Type> types = const [
    SetSysRoleMenusRequest,
    _$SetSysRoleMenusRequest,
  ];

  @override
  final String wireName = r'SetSysRoleMenusRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetSysRoleMenusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'menuIds';
    yield serializers.serialize(
      object.menuIds,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SetSysRoleMenusRequest object, {
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
    required SetSysRoleMenusRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'menuIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.menuIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SetSysRoleMenusRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetSysRoleMenusRequestBuilder();
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
