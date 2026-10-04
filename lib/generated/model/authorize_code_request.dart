//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'authorize_code_request.g.dart';

/// AuthorizeCodeRequest
///
/// Properties:
/// * [clientId]
/// * [redirectUri]
/// * [responseType]
/// * [scope]
/// * [state]
@BuiltValue()
abstract class AuthorizeCodeRequest
    implements Built<AuthorizeCodeRequest, AuthorizeCodeRequestBuilder> {
  @BuiltValueField(wireName: r'clientId')
  String get clientId;

  @BuiltValueField(wireName: r'redirectUri')
  String get redirectUri;

  @BuiltValueField(wireName: r'responseType')
  AuthorizeCodeRequestResponseTypeEnum get responseType;
  // enum responseTypeEnum {  code,  };

  @BuiltValueField(wireName: r'scope')
  String? get scope;

  @BuiltValueField(wireName: r'state')
  String get state;

  AuthorizeCodeRequest._();

  factory AuthorizeCodeRequest([void updates(AuthorizeCodeRequestBuilder b)]) =
      _$AuthorizeCodeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthorizeCodeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthorizeCodeRequest> get serializer =>
      _$AuthorizeCodeRequestSerializer();
}

class _$AuthorizeCodeRequestSerializer
    implements PrimitiveSerializer<AuthorizeCodeRequest> {
  @override
  final Iterable<Type> types = const [
    AuthorizeCodeRequest,
    _$AuthorizeCodeRequest,
  ];

  @override
  final String wireName = r'AuthorizeCodeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthorizeCodeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'clientId';
    yield serializers.serialize(
      object.clientId,
      specifiedType: const FullType(String),
    );
    yield r'redirectUri';
    yield serializers.serialize(
      object.redirectUri,
      specifiedType: const FullType(String),
    );
    yield r'responseType';
    yield serializers.serialize(
      object.responseType,
      specifiedType: const FullType(AuthorizeCodeRequestResponseTypeEnum),
    );
    if (object.scope != null) {
      yield r'scope';
      yield serializers.serialize(
        object.scope,
        specifiedType: const FullType(String),
      );
    }
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthorizeCodeRequest object, {
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
    required AuthorizeCodeRequestBuilder result,
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
        case r'redirectUri':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.redirectUri = valueDes;
          break;
        case r'responseType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthorizeCodeRequestResponseTypeEnum),
          ) as AuthorizeCodeRequestResponseTypeEnum;
          result.responseType = valueDes;
          break;
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.scope = valueDes;
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
  AuthorizeCodeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthorizeCodeRequestBuilder();
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

class AuthorizeCodeRequestResponseTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'code')
  static const AuthorizeCodeRequestResponseTypeEnum code =
      _$authorizeCodeRequestResponseTypeEnum_code;

  static Serializer<AuthorizeCodeRequestResponseTypeEnum> get serializer =>
      _$authorizeCodeRequestResponseTypeEnumSerializer;

  const AuthorizeCodeRequestResponseTypeEnum._(String name) : super(name);

  static BuiltSet<AuthorizeCodeRequestResponseTypeEnum> get values =>
      _$authorizeCodeRequestResponseTypeEnumValues;
  static AuthorizeCodeRequestResponseTypeEnum valueOf(String name) =>
      _$authorizeCodeRequestResponseTypeEnumValueOf(name);
}
