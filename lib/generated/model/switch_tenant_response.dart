//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'switch_tenant_response.g.dart';

/// SwitchTenantResponse
///
/// Properties:
/// * [accessToken]
/// * [refreshToken]
/// * [expiresAt]
/// * [tenantId]
@BuiltValue()
abstract class SwitchTenantResponse
    implements Built<SwitchTenantResponse, SwitchTenantResponseBuilder> {
  @BuiltValueField(wireName: r'accessToken')
  String get accessToken;

  @BuiltValueField(wireName: r'refreshToken')
  String get refreshToken;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime get expiresAt;

  @BuiltValueField(wireName: r'tenantId')
  String get tenantId;

  SwitchTenantResponse._();

  factory SwitchTenantResponse([void updates(SwitchTenantResponseBuilder b)]) =
      _$SwitchTenantResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SwitchTenantResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SwitchTenantResponse> get serializer =>
      _$SwitchTenantResponseSerializer();
}

class _$SwitchTenantResponseSerializer
    implements PrimitiveSerializer<SwitchTenantResponse> {
  @override
  final Iterable<Type> types = const [
    SwitchTenantResponse,
    _$SwitchTenantResponse,
  ];

  @override
  final String wireName = r'SwitchTenantResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SwitchTenantResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'accessToken';
    yield serializers.serialize(
      object.accessToken,
      specifiedType: const FullType(String),
    );
    yield r'refreshToken';
    yield serializers.serialize(
      object.refreshToken,
      specifiedType: const FullType(String),
    );
    yield r'expiresAt';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'tenantId';
    yield serializers.serialize(
      object.tenantId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SwitchTenantResponse object, {
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
    required SwitchTenantResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'accessToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessToken = valueDes;
          break;
        case r'refreshToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.refreshToken = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'tenantId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tenantId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SwitchTenantResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SwitchTenantResponseBuilder();
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
