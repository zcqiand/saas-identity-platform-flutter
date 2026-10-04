//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:saas_identity_platform_flutter/generated/model/o_auth_client.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_clients_list_clients200_response.g.dart';

/// AdminClientsListClients200Response
///
/// Properties:
/// * [items]
/// * [page]
/// * [pageSize]
/// * [total]
@BuiltValue()
abstract class AdminClientsListClients200Response
    implements
        Built<
          AdminClientsListClients200Response,
          AdminClientsListClients200ResponseBuilder
        > {
  @BuiltValueField(wireName: r'items')
  BuiltList<OAuthClient> get items;

  @BuiltValueField(wireName: r'page')
  int get page;

  @BuiltValueField(wireName: r'pageSize')
  int get pageSize;

  @BuiltValueField(wireName: r'total')
  int get total;

  AdminClientsListClients200Response._();

  factory AdminClientsListClients200Response([
    void updates(AdminClientsListClients200ResponseBuilder b),
  ]) = _$AdminClientsListClients200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminClientsListClients200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminClientsListClients200Response> get serializer =>
      _$AdminClientsListClients200ResponseSerializer();
}

class _$AdminClientsListClients200ResponseSerializer
    implements PrimitiveSerializer<AdminClientsListClients200Response> {
  @override
  final Iterable<Type> types = const [
    AdminClientsListClients200Response,
    _$AdminClientsListClients200Response,
  ];

  @override
  final String wireName = r'AdminClientsListClients200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminClientsListClients200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(OAuthClient)]),
    );
    yield r'page';
    yield serializers.serialize(
      object.page,
      specifiedType: const FullType(int),
    );
    yield r'pageSize';
    yield serializers.serialize(
      object.pageSize,
      specifiedType: const FullType(int),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminClientsListClients200Response object, {
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
    required AdminClientsListClients200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OAuthClient)]),
          ) as BuiltList<OAuthClient>;
          result.items.replace(valueDes);
          break;
        case r'page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.page = valueDes;
          break;
        case r'pageSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageSize = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminClientsListClients200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminClientsListClients200ResponseBuilder();
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
