//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:saas_identity_platform_flutter/generated/model/sys_menu_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'effective_menu_node.g.dart';

/// EffectiveMenuNode
///
/// Properties:
/// * [id]
/// * [clientId]
/// * [parentId]
/// * [title]
/// * [type]
/// * [path]
/// * [component]
/// * [perms]
/// * [icon]
/// * [sortOrder]
/// * [children]
@BuiltValue()
abstract class EffectiveMenuNode
    implements Built<EffectiveMenuNode, EffectiveMenuNodeBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'clientId')
  String get clientId;

  @BuiltValueField(wireName: r'parentId')
  String get parentId;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'type')
  SysMenuType get type;
  // enum typeEnum {  directory,  menu,  button,  };

  @BuiltValueField(wireName: r'path')
  String? get path;

  @BuiltValueField(wireName: r'component')
  String? get component;

  @BuiltValueField(wireName: r'perms')
  String? get perms;

  @BuiltValueField(wireName: r'icon')
  String? get icon;

  @BuiltValueField(wireName: r'sortOrder')
  int get sortOrder;

  @BuiltValueField(wireName: r'children')
  BuiltList<EffectiveMenuNode> get children;

  EffectiveMenuNode._();

  factory EffectiveMenuNode([void updates(EffectiveMenuNodeBuilder b)]) =
      _$EffectiveMenuNode;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EffectiveMenuNodeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EffectiveMenuNode> get serializer =>
      _$EffectiveMenuNodeSerializer();
}

class _$EffectiveMenuNodeSerializer
    implements PrimitiveSerializer<EffectiveMenuNode> {
  @override
  final Iterable<Type> types = const [EffectiveMenuNode, _$EffectiveMenuNode];

  @override
  final String wireName = r'EffectiveMenuNode';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EffectiveMenuNode object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'clientId';
    yield serializers.serialize(
      object.clientId,
      specifiedType: const FullType(String),
    );
    yield r'parentId';
    yield serializers.serialize(
      object.parentId,
      specifiedType: const FullType(String),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(SysMenuType),
    );
    if (object.path != null) {
      yield r'path';
      yield serializers.serialize(
        object.path,
        specifiedType: const FullType(String),
      );
    }
    if (object.component != null) {
      yield r'component';
      yield serializers.serialize(
        object.component,
        specifiedType: const FullType(String),
      );
    }
    if (object.perms != null) {
      yield r'perms';
      yield serializers.serialize(
        object.perms,
        specifiedType: const FullType(String),
      );
    }
    if (object.icon != null) {
      yield r'icon';
      yield serializers.serialize(
        object.icon,
        specifiedType: const FullType(String),
      );
    }
    yield r'sortOrder';
    yield serializers.serialize(
      object.sortOrder,
      specifiedType: const FullType(int),
    );
    yield r'children';
    yield serializers.serialize(
      object.children,
      specifiedType: const FullType(BuiltList, [FullType(EffectiveMenuNode)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EffectiveMenuNode object, {
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
    required EffectiveMenuNodeBuilder result,
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
        case r'clientId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientId = valueDes;
          break;
        case r'parentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.parentId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SysMenuType),
          ) as SysMenuType;
          result.type = valueDes;
          break;
        case r'path':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.path = valueDes;
          break;
        case r'component':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.component = valueDes;
          break;
        case r'perms':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.perms = valueDes;
          break;
        case r'icon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.icon = valueDes;
          break;
        case r'sortOrder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sortOrder = valueDes;
          break;
        case r'children':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(EffectiveMenuNode),
            ]),
          ) as BuiltList<EffectiveMenuNode>;
          result.children.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EffectiveMenuNode deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EffectiveMenuNodeBuilder();
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
