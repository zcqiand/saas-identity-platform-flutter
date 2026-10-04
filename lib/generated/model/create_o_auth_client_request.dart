//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_o_auth_client_request.g.dart';

/// CreateOAuthClientRequest
///
/// Properties:
/// * [clientId]
/// * [clientName]
/// * [clientSecret]
/// * [grantTypes]
/// * [redirectUris]
/// * [scopes]
/// * [accessTokenValidity]
/// * [refreshTokenValidity]
/// * [autoApprove]
@BuiltValue()
abstract class CreateOAuthClientRequest
    implements
        Built<CreateOAuthClientRequest, CreateOAuthClientRequestBuilder> {
  @BuiltValueField(wireName: r'clientId')
  String get clientId;

  @BuiltValueField(wireName: r'clientName')
  String get clientName;

  @BuiltValueField(wireName: r'clientSecret')
  String get clientSecret;

  @BuiltValueField(wireName: r'grantTypes')
  String get grantTypes;

  @BuiltValueField(wireName: r'redirectUris')
  String get redirectUris;

  @BuiltValueField(wireName: r'scopes')
  String? get scopes;

  @BuiltValueField(wireName: r'accessTokenValidity')
  int? get accessTokenValidity;

  @BuiltValueField(wireName: r'refreshTokenValidity')
  int? get refreshTokenValidity;

  @BuiltValueField(wireName: r'autoApprove')
  bool? get autoApprove;

  CreateOAuthClientRequest._();

  factory CreateOAuthClientRequest([
    void updates(CreateOAuthClientRequestBuilder b),
  ]) = _$CreateOAuthClientRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateOAuthClientRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateOAuthClientRequest> get serializer =>
      _$CreateOAuthClientRequestSerializer();
}

class _$CreateOAuthClientRequestSerializer
    implements PrimitiveSerializer<CreateOAuthClientRequest> {
  @override
  final Iterable<Type> types = const [
    CreateOAuthClientRequest,
    _$CreateOAuthClientRequest,
  ];

  @override
  final String wireName = r'CreateOAuthClientRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateOAuthClientRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'clientId';
    yield serializers.serialize(
      object.clientId,
      specifiedType: const FullType(String),
    );
    yield r'clientName';
    yield serializers.serialize(
      object.clientName,
      specifiedType: const FullType(String),
    );
    yield r'clientSecret';
    yield serializers.serialize(
      object.clientSecret,
      specifiedType: const FullType(String),
    );
    yield r'grantTypes';
    yield serializers.serialize(
      object.grantTypes,
      specifiedType: const FullType(String),
    );
    yield r'redirectUris';
    yield serializers.serialize(
      object.redirectUris,
      specifiedType: const FullType(String),
    );
    if (object.scopes != null) {
      yield r'scopes';
      yield serializers.serialize(
        object.scopes,
        specifiedType: const FullType(String),
      );
    }
    if (object.accessTokenValidity != null) {
      yield r'accessTokenValidity';
      yield serializers.serialize(
        object.accessTokenValidity,
        specifiedType: const FullType(int),
      );
    }
    if (object.refreshTokenValidity != null) {
      yield r'refreshTokenValidity';
      yield serializers.serialize(
        object.refreshTokenValidity,
        specifiedType: const FullType(int),
      );
    }
    if (object.autoApprove != null) {
      yield r'autoApprove';
      yield serializers.serialize(
        object.autoApprove,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateOAuthClientRequest object, {
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
    required CreateOAuthClientRequestBuilder result,
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
        case r'clientName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientName = valueDes;
          break;
        case r'clientSecret':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientSecret = valueDes;
          break;
        case r'grantTypes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.grantTypes = valueDes;
          break;
        case r'redirectUris':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.redirectUris = valueDes;
          break;
        case r'scopes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.scopes = valueDes;
          break;
        case r'accessTokenValidity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.accessTokenValidity = valueDes;
          break;
        case r'refreshTokenValidity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.refreshTokenValidity = valueDes;
          break;
        case r'autoApprove':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.autoApprove = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateOAuthClientRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateOAuthClientRequestBuilder();
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
