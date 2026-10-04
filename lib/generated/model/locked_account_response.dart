//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'locked_account_response.g.dart';

/// LockedAccountResponse
///
/// Properties:
/// * [code]
/// * [message]
/// * [lockedUntil]
/// * [remainingAttempts]
@BuiltValue()
abstract class LockedAccountResponse
    implements Built<LockedAccountResponse, LockedAccountResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'lockedUntil')
  DateTime get lockedUntil;

  @BuiltValueField(wireName: r'remainingAttempts')
  int? get remainingAttempts;

  LockedAccountResponse._();

  factory LockedAccountResponse([
    void updates(LockedAccountResponseBuilder b),
  ]) = _$LockedAccountResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LockedAccountResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LockedAccountResponse> get serializer =>
      _$LockedAccountResponseSerializer();
}

class _$LockedAccountResponseSerializer
    implements PrimitiveSerializer<LockedAccountResponse> {
  @override
  final Iterable<Type> types = const [
    LockedAccountResponse,
    _$LockedAccountResponse,
  ];

  @override
  final String wireName = r'LockedAccountResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LockedAccountResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'lockedUntil';
    yield serializers.serialize(
      object.lockedUntil,
      specifiedType: const FullType(DateTime),
    );
    if (object.remainingAttempts != null) {
      yield r'remainingAttempts';
      yield serializers.serialize(
        object.remainingAttempts,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LockedAccountResponse object, {
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
    required LockedAccountResponseBuilder result,
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
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'lockedUntil':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.lockedUntil = valueDes;
          break;
        case r'remainingAttempts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.remainingAttempts = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LockedAccountResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LockedAccountResponseBuilder();
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
