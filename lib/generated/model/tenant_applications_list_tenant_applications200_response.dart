//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:saas_identity_platform_flutter/generated/model/tenant_application.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tenant_applications_list_tenant_applications200_response.g.dart';

/// TenantApplicationsListTenantApplications200Response
///
/// Properties:
/// * [items]
/// * [page]
/// * [pageSize]
/// * [total]
@BuiltValue()
abstract class TenantApplicationsListTenantApplications200Response
    implements
        Built<
          TenantApplicationsListTenantApplications200Response,
          TenantApplicationsListTenantApplications200ResponseBuilder
        > {
  @BuiltValueField(wireName: r'items')
  BuiltList<TenantApplication> get items;

  @BuiltValueField(wireName: r'page')
  int get page;

  @BuiltValueField(wireName: r'pageSize')
  int get pageSize;

  @BuiltValueField(wireName: r'total')
  int get total;

  TenantApplicationsListTenantApplications200Response._();

  factory TenantApplicationsListTenantApplications200Response([
    void updates(TenantApplicationsListTenantApplications200ResponseBuilder b),
  ]) = _$TenantApplicationsListTenantApplications200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(
    TenantApplicationsListTenantApplications200ResponseBuilder b,
  ) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TenantApplicationsListTenantApplications200Response>
  get serializer =>
      _$TenantApplicationsListTenantApplications200ResponseSerializer();
}

class _$TenantApplicationsListTenantApplications200ResponseSerializer
    implements
        PrimitiveSerializer<
          TenantApplicationsListTenantApplications200Response
        > {
  @override
  final Iterable<Type> types = const [
    TenantApplicationsListTenantApplications200Response,
    _$TenantApplicationsListTenantApplications200Response,
  ];

  @override
  final String wireName =
      r'TenantApplicationsListTenantApplications200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TenantApplicationsListTenantApplications200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(TenantApplication)]),
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
    TenantApplicationsListTenantApplications200Response object, {
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
    required TenantApplicationsListTenantApplications200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(TenantApplication),
            ]),
          ) as BuiltList<TenantApplication>;
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
  TenantApplicationsListTenantApplications200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TenantApplicationsListTenantApplications200ResponseBuilder();
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
