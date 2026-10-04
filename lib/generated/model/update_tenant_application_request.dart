//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_tenant_application_request.g.dart';

/// UpdateTenantApplicationRequest
///
/// Properties:
/// * [status]
/// * [expireTime]
@BuiltValue()
abstract class UpdateTenantApplicationRequest
    implements
        Built<
          UpdateTenantApplicationRequest,
          UpdateTenantApplicationRequestBuilder
        > {
  @BuiltValueField(wireName: r'status')
  int get status;

  @BuiltValueField(wireName: r'expireTime')
  DateTime? get expireTime;

  UpdateTenantApplicationRequest._();

  factory UpdateTenantApplicationRequest([
    void updates(UpdateTenantApplicationRequestBuilder b),
  ]) = _$UpdateTenantApplicationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateTenantApplicationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateTenantApplicationRequest> get serializer =>
      _$UpdateTenantApplicationRequestSerializer();
}

class _$UpdateTenantApplicationRequestSerializer
    implements PrimitiveSerializer<UpdateTenantApplicationRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateTenantApplicationRequest,
    _$UpdateTenantApplicationRequest,
  ];

  @override
  final String wireName = r'UpdateTenantApplicationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateTenantApplicationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(int),
    );
    if (object.expireTime != null) {
      yield r'expireTime';
      yield serializers.serialize(
        object.expireTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateTenantApplicationRequest object, {
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
    required UpdateTenantApplicationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.status = valueDes;
          break;
        case r'expireTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expireTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateTenantApplicationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateTenantApplicationRequestBuilder();
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
