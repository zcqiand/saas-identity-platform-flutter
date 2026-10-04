//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_sys_role_request.g.dart';

/// CreateSysRoleRequest
///
/// Properties:
/// * [clientId]
/// * [roleCode]
/// * [roleName]
/// * [description]
/// * [isPreset]
@BuiltValue()
abstract class CreateSysRoleRequest
    implements Built<CreateSysRoleRequest, CreateSysRoleRequestBuilder> {
  @BuiltValueField(wireName: r'clientId')
  String get clientId;

  @BuiltValueField(wireName: r'roleCode')
  String get roleCode;

  @BuiltValueField(wireName: r'roleName')
  String get roleName;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'isPreset')
  bool? get isPreset;

  CreateSysRoleRequest._();

  factory CreateSysRoleRequest([void updates(CreateSysRoleRequestBuilder b)]) =
      _$CreateSysRoleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateSysRoleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateSysRoleRequest> get serializer =>
      _$CreateSysRoleRequestSerializer();
}

class _$CreateSysRoleRequestSerializer
    implements PrimitiveSerializer<CreateSysRoleRequest> {
  @override
  final Iterable<Type> types = const [
    CreateSysRoleRequest,
    _$CreateSysRoleRequest,
  ];

  @override
  final String wireName = r'CreateSysRoleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateSysRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'clientId';
    yield serializers.serialize(
      object.clientId,
      specifiedType: const FullType(String),
    );
    yield r'roleCode';
    yield serializers.serialize(
      object.roleCode,
      specifiedType: const FullType(String),
    );
    yield r'roleName';
    yield serializers.serialize(
      object.roleName,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.isPreset != null) {
      yield r'isPreset';
      yield serializers.serialize(
        object.isPreset,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateSysRoleRequest object, {
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
    required CreateSysRoleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'clientId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientId = valueDes;
          break;
        case r'roleCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.roleCode = valueDes;
          break;
        case r'roleName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.roleName = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'isPreset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isPreset = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateSysRoleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateSysRoleRequestBuilder();
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
