//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_o_auth_client_request.g.dart';

/// UpdateOAuthClientRequest
///
/// Properties:
/// * [clientName]
/// * [grantTypes]
/// * [redirectUris]
/// * [scopes]
/// * [accessTokenValidity]
/// * [refreshTokenValidity]
/// * [autoApprove]
/// * [status]
@BuiltValue()
abstract class UpdateOAuthClientRequest
    implements
        Built<UpdateOAuthClientRequest, UpdateOAuthClientRequestBuilder> {
  @BuiltValueField(wireName: r'clientName')
  String? get clientName;

  @BuiltValueField(wireName: r'grantTypes')
  String? get grantTypes;

  @BuiltValueField(wireName: r'redirectUris')
  String? get redirectUris;

  @BuiltValueField(wireName: r'scopes')
  String? get scopes;

  @BuiltValueField(wireName: r'accessTokenValidity')
  int? get accessTokenValidity;

  @BuiltValueField(wireName: r'refreshTokenValidity')
  int? get refreshTokenValidity;

  @BuiltValueField(wireName: r'autoApprove')
  bool? get autoApprove;

  @BuiltValueField(wireName: r'status')
  int? get status;

  UpdateOAuthClientRequest._();

  factory UpdateOAuthClientRequest([
    void updates(UpdateOAuthClientRequestBuilder b),
  ]) = _$UpdateOAuthClientRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateOAuthClientRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateOAuthClientRequest> get serializer =>
      _$UpdateOAuthClientRequestSerializer();
}

class _$UpdateOAuthClientRequestSerializer
    implements PrimitiveSerializer<UpdateOAuthClientRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateOAuthClientRequest,
    _$UpdateOAuthClientRequest,
  ];

  @override
  final String wireName = r'UpdateOAuthClientRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateOAuthClientRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.clientName != null) {
      yield r'clientName';
      yield serializers.serialize(
        object.clientName,
        specifiedType: const FullType(String),
      );
    }
    if (object.grantTypes != null) {
      yield r'grantTypes';
      yield serializers.serialize(
        object.grantTypes,
        specifiedType: const FullType(String),
      );
    }
    if (object.redirectUris != null) {
      yield r'redirectUris';
      yield serializers.serialize(
        object.redirectUris,
        specifiedType: const FullType(String),
      );
    }
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
    UpdateOAuthClientRequest object, {
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
    required UpdateOAuthClientRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'clientName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.clientName = valueDes;
          break;
        case r'grantTypes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.grantTypes = valueDes;
          break;
        case r'redirectUris':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
  UpdateOAuthClientRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateOAuthClientRequestBuilder();
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
