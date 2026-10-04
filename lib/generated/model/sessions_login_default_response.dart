//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:saas_identity_platform_flutter/generated/model/error_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:saas_identity_platform_flutter/generated/model/locked_account_response.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'sessions_login_default_response.g.dart';

/// SessionsLoginDefaultResponse
///
/// Properties:
/// * [code]
/// * [message]
/// * [lockedUntil]
/// * [remainingAttempts]
/// * [details]
@BuiltValue()
abstract class SessionsLoginDefaultResponse
    implements
        Built<
          SessionsLoginDefaultResponse,
          SessionsLoginDefaultResponseBuilder
        > {
  /// Any Of [ErrorResponse], [LockedAccountResponse]
  AnyOf get anyOf;

  SessionsLoginDefaultResponse._();

  factory SessionsLoginDefaultResponse([
    void updates(SessionsLoginDefaultResponseBuilder b),
  ]) = _$SessionsLoginDefaultResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SessionsLoginDefaultResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SessionsLoginDefaultResponse> get serializer =>
      _$SessionsLoginDefaultResponseSerializer();
}

class _$SessionsLoginDefaultResponseSerializer
    implements PrimitiveSerializer<SessionsLoginDefaultResponse> {
  @override
  final Iterable<Type> types = const [
    SessionsLoginDefaultResponse,
    _$SessionsLoginDefaultResponse,
  ];

  @override
  final String wireName = r'SessionsLoginDefaultResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SessionsLoginDefaultResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    SessionsLoginDefaultResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(
      anyOf,
      specifiedType: FullType(
        AnyOf,
        anyOf.types.map((type) => FullType(type)).toList(),
      ),
    )!;
  }

  @override
  SessionsLoginDefaultResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SessionsLoginDefaultResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [
      FullType(LockedAccountResponse),
      FullType(ErrorResponse),
    ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(
      anyOfDataSrc,
      specifiedType: targetType,
    ) as AnyOf;
    return result.build();
  }
}
