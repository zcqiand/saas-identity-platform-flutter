//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_sys_role_request.g.dart';

/// UpdateSysRoleRequest
///
/// Properties:
/// * [roleName]
/// * [description]
/// * [status]
@BuiltValue()
abstract class UpdateSysRoleRequest
    implements Built<UpdateSysRoleRequest, UpdateSysRoleRequestBuilder> {
  @BuiltValueField(wireName: r'roleName')
  String? get roleName;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'status')
  int? get status;

  UpdateSysRoleRequest._();

  factory UpdateSysRoleRequest([void updates(UpdateSysRoleRequestBuilder b)]) =
      _$UpdateSysRoleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateSysRoleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateSysRoleRequest> get serializer =>
      _$UpdateSysRoleRequestSerializer();
}

class _$UpdateSysRoleRequestSerializer
    implements PrimitiveSerializer<UpdateSysRoleRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateSysRoleRequest,
    _$UpdateSysRoleRequest,
  ];

  @override
  final String wireName = r'UpdateSysRoleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateSysRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.roleName != null) {
      yield r'roleName';
      yield serializers.serialize(
        object.roleName,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
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
    UpdateSysRoleRequest object, {
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
    required UpdateSysRoleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'roleName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
  UpdateSysRoleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateSysRoleRequestBuilder();
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
