//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:saas_identity_platform_flutter/generated/model/tenant_member_user_view.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tenant_members_list_tenant_users200_response.g.dart';

/// TenantMembersListTenantUsers200Response
///
/// Properties:
/// * [items]
/// * [page]
/// * [pageSize]
/// * [total]
@BuiltValue()
abstract class TenantMembersListTenantUsers200Response
    implements
        Built<
          TenantMembersListTenantUsers200Response,
          TenantMembersListTenantUsers200ResponseBuilder
        > {
  @BuiltValueField(wireName: r'items')
  BuiltList<TenantMemberUserView> get items;

  @BuiltValueField(wireName: r'page')
  int get page;

  @BuiltValueField(wireName: r'pageSize')
  int get pageSize;

  @BuiltValueField(wireName: r'total')
  int get total;

  TenantMembersListTenantUsers200Response._();

  factory TenantMembersListTenantUsers200Response([
    void updates(TenantMembersListTenantUsers200ResponseBuilder b),
  ]) = _$TenantMembersListTenantUsers200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TenantMembersListTenantUsers200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TenantMembersListTenantUsers200Response> get serializer =>
      _$TenantMembersListTenantUsers200ResponseSerializer();
}

class _$TenantMembersListTenantUsers200ResponseSerializer
    implements PrimitiveSerializer<TenantMembersListTenantUsers200Response> {
  @override
  final Iterable<Type> types = const [
    TenantMembersListTenantUsers200Response,
    _$TenantMembersListTenantUsers200Response,
  ];

  @override
  final String wireName = r'TenantMembersListTenantUsers200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TenantMembersListTenantUsers200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [
        FullType(TenantMemberUserView),
      ]),
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
    TenantMembersListTenantUsers200Response object, {
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
    required TenantMembersListTenantUsers200ResponseBuilder result,
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
              FullType(TenantMemberUserView),
            ]),
          ) as BuiltList<TenantMemberUserView>;
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
  TenantMembersListTenantUsers200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TenantMembersListTenantUsers200ResponseBuilder();
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
