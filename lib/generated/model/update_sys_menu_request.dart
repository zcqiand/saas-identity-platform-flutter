//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:saas_identity_platform_flutter/generated/model/sys_menu_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_sys_menu_request.g.dart';

/// UpdateSysMenuRequest
///
/// Properties:
/// * [parentId]
/// * [title]
/// * [type]
/// * [path]
/// * [component]
/// * [perms]
/// * [icon]
/// * [sortOrder]
/// * [status]
@BuiltValue()
abstract class UpdateSysMenuRequest
    implements Built<UpdateSysMenuRequest, UpdateSysMenuRequestBuilder> {
  @BuiltValueField(wireName: r'parentId')
  String? get parentId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'type')
  SysMenuType? get type;
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
  int? get sortOrder;

  @BuiltValueField(wireName: r'status')
  int? get status;

  UpdateSysMenuRequest._();

  factory UpdateSysMenuRequest([void updates(UpdateSysMenuRequestBuilder b)]) =
      _$UpdateSysMenuRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateSysMenuRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateSysMenuRequest> get serializer =>
      _$UpdateSysMenuRequestSerializer();
}

class _$UpdateSysMenuRequestSerializer
    implements PrimitiveSerializer<UpdateSysMenuRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateSysMenuRequest,
    _$UpdateSysMenuRequest,
  ];

  @override
  final String wireName = r'UpdateSysMenuRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateSysMenuRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.parentId != null) {
      yield r'parentId';
      yield serializers.serialize(
        object.parentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(SysMenuType),
      );
    }
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
    if (object.sortOrder != null) {
      yield r'sortOrder';
      yield serializers.serialize(
        object.sortOrder,
        specifiedType: const FullType(int),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateSysMenuRequest object, {
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
    required UpdateSysMenuRequestBuilder result,
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
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SysMenuType),
          ) as SysMenuType?;
          if (valueDes == null) continue;
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
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sortOrder = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
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
  UpdateSysMenuRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateSysMenuRequestBuilder();
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
