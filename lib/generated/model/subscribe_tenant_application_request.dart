//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subscribe_tenant_application_request.g.dart';

/// SubscribeTenantApplicationRequest
///
/// Properties:
/// * [clientId]
/// * [expireTime]
@BuiltValue()
abstract class SubscribeTenantApplicationRequest
    implements
        Built<
          SubscribeTenantApplicationRequest,
          SubscribeTenantApplicationRequestBuilder
        > {
  @BuiltValueField(wireName: r'clientId')
  String get clientId;

  @BuiltValueField(wireName: r'expireTime')
  DateTime? get expireTime;

  SubscribeTenantApplicationRequest._();

  factory SubscribeTenantApplicationRequest([
    void updates(SubscribeTenantApplicationRequestBuilder b),
  ]) = _$SubscribeTenantApplicationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubscribeTenantApplicationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubscribeTenantApplicationRequest> get serializer =>
      _$SubscribeTenantApplicationRequestSerializer();
}

class _$SubscribeTenantApplicationRequestSerializer
    implements PrimitiveSerializer<SubscribeTenantApplicationRequest> {
  @override
  final Iterable<Type> types = const [
    SubscribeTenantApplicationRequest,
    _$SubscribeTenantApplicationRequest,
  ];

  @override
  final String wireName = r'SubscribeTenantApplicationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubscribeTenantApplicationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'clientId';
    yield serializers.serialize(
      object.clientId,
      specifiedType: const FullType(String),
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
    SubscribeTenantApplicationRequest object, {
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
    required SubscribeTenantApplicationRequestBuilder result,
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
  SubscribeTenantApplicationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubscribeTenantApplicationRequestBuilder();
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
