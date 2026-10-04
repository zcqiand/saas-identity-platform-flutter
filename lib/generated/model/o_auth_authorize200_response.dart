//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'o_auth_authorize200_response.g.dart';

/// OAuthAuthorize200Response
///
/// Properties:
/// * [code]
/// * [state]
@BuiltValue()
abstract class OAuthAuthorize200Response
    implements
        Built<OAuthAuthorize200Response, OAuthAuthorize200ResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'state')
  String get state;

  OAuthAuthorize200Response._();

  factory OAuthAuthorize200Response([
    void updates(OAuthAuthorize200ResponseBuilder b),
  ]) = _$OAuthAuthorize200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OAuthAuthorize200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OAuthAuthorize200Response> get serializer =>
      _$OAuthAuthorize200ResponseSerializer();
}

class _$OAuthAuthorize200ResponseSerializer
    implements PrimitiveSerializer<OAuthAuthorize200Response> {
  @override
  final Iterable<Type> types = const [
    OAuthAuthorize200Response,
    _$OAuthAuthorize200Response,
  ];

  @override
  final String wireName = r'OAuthAuthorize200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OAuthAuthorize200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OAuthAuthorize200Response object, {
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
    required OAuthAuthorize200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.state = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OAuthAuthorize200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OAuthAuthorize200ResponseBuilder();
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
