//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'token_request.g.dart';

/// TokenRequest
///
/// Properties:
/// * [grantType]
/// * [code]
/// * [refreshToken]
/// * [clientId]
/// * [clientSecret]
/// * [redirectUri]
@BuiltValue()
abstract class TokenRequest
    implements Built<TokenRequest, TokenRequestBuilder> {
  @BuiltValueField(wireName: r'grantType')
  TokenRequestGrantTypeEnum get grantType;
  // enum grantTypeEnum {  authorization_code,  refresh_token,  };

  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'refreshToken')
  String? get refreshToken;

  @BuiltValueField(wireName: r'clientId')
  String get clientId;

  @BuiltValueField(wireName: r'clientSecret')
  String? get clientSecret;

  @BuiltValueField(wireName: r'redirectUri')
  String? get redirectUri;

  TokenRequest._();

  factory TokenRequest([void updates(TokenRequestBuilder b)]) = _$TokenRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TokenRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TokenRequest> get serializer => _$TokenRequestSerializer();
}

class _$TokenRequestSerializer implements PrimitiveSerializer<TokenRequest> {
  @override
  final Iterable<Type> types = const [TokenRequest, _$TokenRequest];

  @override
  final String wireName = r'TokenRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'grantType';
    yield serializers.serialize(
      object.grantType,
      specifiedType: const FullType(TokenRequestGrantTypeEnum),
    );
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(String),
      );
    }
    if (object.refreshToken != null) {
      yield r'refreshToken';
      yield serializers.serialize(
        object.refreshToken,
        specifiedType: const FullType(String),
      );
    }
    yield r'clientId';
    yield serializers.serialize(
      object.clientId,
      specifiedType: const FullType(String),
    );
    if (object.clientSecret != null) {
      yield r'clientSecret';
      yield serializers.serialize(
        object.clientSecret,
        specifiedType: const FullType(String),
      );
    }
    if (object.redirectUri != null) {
      yield r'redirectUri';
      yield serializers.serialize(
        object.redirectUri,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TokenRequest object, {
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
    required TokenRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'grantType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TokenRequestGrantTypeEnum),
          ) as TokenRequestGrantTypeEnum;
          result.grantType = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.code = valueDes;
          break;
        case r'refreshToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.refreshToken = valueDes;
          break;
        case r'clientId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientId = valueDes;
          break;
        case r'clientSecret':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.clientSecret = valueDes;
          break;
        case r'redirectUri':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.redirectUri = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TokenRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TokenRequestBuilder();
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

class TokenRequestGrantTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'authorization_code')
  static const TokenRequestGrantTypeEnum authorizationCode =
      _$tokenRequestGrantTypeEnum_authorizationCode;
  @BuiltValueEnumConst(wireName: r'refresh_token')
  static const TokenRequestGrantTypeEnum refreshToken =
      _$tokenRequestGrantTypeEnum_refreshToken;

  static Serializer<TokenRequestGrantTypeEnum> get serializer =>
      _$tokenRequestGrantTypeEnumSerializer;

  const TokenRequestGrantTypeEnum._(String name) : super(name);

  static BuiltSet<TokenRequestGrantTypeEnum> get values =>
      _$tokenRequestGrantTypeEnumValues;
  static TokenRequestGrantTypeEnum valueOf(String name) =>
      _$tokenRequestGrantTypeEnumValueOf(name);
}
