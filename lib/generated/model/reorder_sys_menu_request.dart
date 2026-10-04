//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reorder_sys_menu_request.g.dart';

/// ReorderSysMenuRequest
///
/// Properties:
/// * [orderedMenuIds]
@BuiltValue()
abstract class ReorderSysMenuRequest
    implements Built<ReorderSysMenuRequest, ReorderSysMenuRequestBuilder> {
  @BuiltValueField(wireName: r'orderedMenuIds')
  BuiltList<String> get orderedMenuIds;

  ReorderSysMenuRequest._();

  factory ReorderSysMenuRequest([
    void updates(ReorderSysMenuRequestBuilder b),
  ]) = _$ReorderSysMenuRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReorderSysMenuRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReorderSysMenuRequest> get serializer =>
      _$ReorderSysMenuRequestSerializer();
}

class _$ReorderSysMenuRequestSerializer
    implements PrimitiveSerializer<ReorderSysMenuRequest> {
  @override
  final Iterable<Type> types = const [
    ReorderSysMenuRequest,
    _$ReorderSysMenuRequest,
  ];

  @override
  final String wireName = r'ReorderSysMenuRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReorderSysMenuRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'orderedMenuIds';
    yield serializers.serialize(
      object.orderedMenuIds,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReorderSysMenuRequest object, {
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
    required ReorderSysMenuRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'orderedMenuIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.orderedMenuIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReorderSysMenuRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReorderSysMenuRequestBuilder();
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
