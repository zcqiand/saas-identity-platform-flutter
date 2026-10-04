//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_clients_set_client_status_request.g.dart';

/// AdminClientsSetClientStatusRequest
///
/// Properties:
/// * [status]
@BuiltValue()
abstract class AdminClientsSetClientStatusRequest
    implements
        Built<
          AdminClientsSetClientStatusRequest,
          AdminClientsSetClientStatusRequestBuilder
        > {
  @BuiltValueField(wireName: r'status')
  int get status;

  AdminClientsSetClientStatusRequest._();

  factory AdminClientsSetClientStatusRequest([
    void updates(AdminClientsSetClientStatusRequestBuilder b),
  ]) = _$AdminClientsSetClientStatusRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminClientsSetClientStatusRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminClientsSetClientStatusRequest> get serializer =>
      _$AdminClientsSetClientStatusRequestSerializer();
}

class _$AdminClientsSetClientStatusRequestSerializer
    implements PrimitiveSerializer<AdminClientsSetClientStatusRequest> {
  @override
  final Iterable<Type> types = const [
    AdminClientsSetClientStatusRequest,
    _$AdminClientsSetClientStatusRequest,
  ];

  @override
  final String wireName = r'AdminClientsSetClientStatusRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminClientsSetClientStatusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminClientsSetClientStatusRequest object, {
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
    required AdminClientsSetClientStatusRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  AdminClientsSetClientStatusRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminClientsSetClientStatusRequestBuilder();
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
