//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'client_menus_move_sys_menu_request.g.dart';

/// ClientMenusMoveSysMenuRequest
///
/// Properties:
/// * [parentId]
@BuiltValue()
abstract class ClientMenusMoveSysMenuRequest
    implements
        Built<
          ClientMenusMoveSysMenuRequest,
          ClientMenusMoveSysMenuRequestBuilder
        > {
  @BuiltValueField(wireName: r'parentId')
  String? get parentId;

  ClientMenusMoveSysMenuRequest._();

  factory ClientMenusMoveSysMenuRequest([
    void updates(ClientMenusMoveSysMenuRequestBuilder b),
  ]) = _$ClientMenusMoveSysMenuRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClientMenusMoveSysMenuRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClientMenusMoveSysMenuRequest> get serializer =>
      _$ClientMenusMoveSysMenuRequestSerializer();
}

class _$ClientMenusMoveSysMenuRequestSerializer
    implements PrimitiveSerializer<ClientMenusMoveSysMenuRequest> {
  @override
  final Iterable<Type> types = const [
    ClientMenusMoveSysMenuRequest,
    _$ClientMenusMoveSysMenuRequest,
  ];

  @override
  final String wireName = r'ClientMenusMoveSysMenuRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClientMenusMoveSysMenuRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.parentId != null) {
      yield r'parentId';
      yield serializers.serialize(
        object.parentId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ClientMenusMoveSysMenuRequest object, {
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
    required ClientMenusMoveSysMenuRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'parentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.parentId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ClientMenusMoveSysMenuRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClientMenusMoveSysMenuRequestBuilder();
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
