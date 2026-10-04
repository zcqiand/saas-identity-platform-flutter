//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'o_auth_client_public_info.g.dart';

/// OAuthClientPublicInfo
///
/// Properties:
/// * [clientId]
/// * [clientName]
/// * [status]
@BuiltValue()
abstract class OAuthClientPublicInfo
    implements Built<OAuthClientPublicInfo, OAuthClientPublicInfoBuilder> {
  @BuiltValueField(wireName: r'clientId')
  String get clientId;

  @BuiltValueField(wireName: r'clientName')
  String get clientName;

  @BuiltValueField(wireName: r'status')
  int get status;

  OAuthClientPublicInfo._();

  factory OAuthClientPublicInfo([
    void updates(OAuthClientPublicInfoBuilder b),
  ]) = _$OAuthClientPublicInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OAuthClientPublicInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OAuthClientPublicInfo> get serializer =>
      _$OAuthClientPublicInfoSerializer();
}

class _$OAuthClientPublicInfoSerializer
    implements PrimitiveSerializer<OAuthClientPublicInfo> {
  @override
  final Iterable<Type> types = const [
    OAuthClientPublicInfo,
    _$OAuthClientPublicInfo,
  ];

  @override
  final String wireName = r'OAuthClientPublicInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OAuthClientPublicInfo object, {
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
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OAuthClientPublicInfo object, {
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
    required OAuthClientPublicInfoBuilder result,
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
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
  OAuthClientPublicInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OAuthClientPublicInfoBuilder();
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
