//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'o_auth_client.g.dart';

/// OAuthClient
///
/// Properties:
/// * [id]
/// * [clientId]
/// * [clientName]
/// * [grantTypes]
/// * [redirectUris]
/// * [scopes]
/// * [accessTokenValidity]
/// * [refreshTokenValidity]
/// * [autoApprove]
/// * [status]
/// * [createdAt]
/// * [updatedAt]
@BuiltValue()
abstract class OAuthClient implements Built<OAuthClient, OAuthClientBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'clientId')
  String get clientId;

  @BuiltValueField(wireName: r'clientName')
  String get clientName;

  @BuiltValueField(wireName: r'grantTypes')
  String get grantTypes;

  @BuiltValueField(wireName: r'redirectUris')
  String get redirectUris;

  @BuiltValueField(wireName: r'scopes')
  String? get scopes;

  @BuiltValueField(wireName: r'accessTokenValidity')
  int get accessTokenValidity;

  @BuiltValueField(wireName: r'refreshTokenValidity')
  int get refreshTokenValidity;

  @BuiltValueField(wireName: r'autoApprove')
  bool get autoApprove;

  @BuiltValueField(wireName: r'status')
  int get status;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime get updatedAt;

  OAuthClient._();

  factory OAuthClient([void updates(OAuthClientBuilder b)]) = _$OAuthClient;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OAuthClientBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OAuthClient> get serializer => _$OAuthClientSerializer();
}

class _$OAuthClientSerializer implements PrimitiveSerializer<OAuthClient> {
  @override
  final Iterable<Type> types = const [OAuthClient, _$OAuthClient];

  @override
  final String wireName = r'OAuthClient';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OAuthClient object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
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
    yield r'accessTokenValidity';
    yield serializers.serialize(
      object.accessTokenValidity,
      specifiedType: const FullType(int),
    );
    yield r'refreshTokenValidity';
    yield serializers.serialize(
      object.refreshTokenValidity,
      specifiedType: const FullType(int),
    );
    yield r'autoApprove';
    yield serializers.serialize(
      object.autoApprove,
      specifiedType: const FullType(bool),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(int),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updatedAt';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OAuthClient object, {
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
    required OAuthClientBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
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
            specifiedType: const FullType(int),
          ) as int;
          result.accessTokenValidity = valueDes;
          break;
        case r'refreshTokenValidity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.refreshTokenValidity = valueDes;
          break;
        case r'autoApprove':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.autoApprove = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.status = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OAuthClient deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OAuthClientBuilder();
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
