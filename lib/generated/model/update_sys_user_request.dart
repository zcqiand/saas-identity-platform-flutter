//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_sys_user_request.g.dart';

/// UpdateSysUserRequest
///
/// Properties:
/// * [email]
/// * [mobile]
@BuiltValue()
abstract class UpdateSysUserRequest
    implements Built<UpdateSysUserRequest, UpdateSysUserRequestBuilder> {
  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'mobile')
  String? get mobile;

  UpdateSysUserRequest._();

  factory UpdateSysUserRequest([void updates(UpdateSysUserRequestBuilder b)]) =
      _$UpdateSysUserRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateSysUserRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateSysUserRequest> get serializer =>
      _$UpdateSysUserRequestSerializer();
}

class _$UpdateSysUserRequestSerializer
    implements PrimitiveSerializer<UpdateSysUserRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateSysUserRequest,
    _$UpdateSysUserRequest,
  ];

  @override
  final String wireName = r'UpdateSysUserRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateSysUserRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
    if (object.mobile != null) {
      yield r'mobile';
      yield serializers.serialize(
        object.mobile,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateSysUserRequest object, {
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
    required UpdateSysUserRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'mobile':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.mobile = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateSysUserRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateSysUserRequestBuilder();
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
