//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:saas_identity_platform_flutter/generated/model/sys_role.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tenant_roles_list_sys_roles200_response.g.dart';

/// TenantRolesListSysRoles200Response
///
/// Properties:
/// * [items]
/// * [page]
/// * [pageSize]
/// * [total]
@BuiltValue()
abstract class TenantRolesListSysRoles200Response
    implements
        Built<
          TenantRolesListSysRoles200Response,
          TenantRolesListSysRoles200ResponseBuilder
        > {
  @BuiltValueField(wireName: r'items')
  BuiltList<SysRole> get items;

  @BuiltValueField(wireName: r'page')
  int get page;

  @BuiltValueField(wireName: r'pageSize')
  int get pageSize;

  @BuiltValueField(wireName: r'total')
  int get total;

  TenantRolesListSysRoles200Response._();

  factory TenantRolesListSysRoles200Response([
    void updates(TenantRolesListSysRoles200ResponseBuilder b),
  ]) = _$TenantRolesListSysRoles200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TenantRolesListSysRoles200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TenantRolesListSysRoles200Response> get serializer =>
      _$TenantRolesListSysRoles200ResponseSerializer();
}

class _$TenantRolesListSysRoles200ResponseSerializer
    implements PrimitiveSerializer<TenantRolesListSysRoles200Response> {
  @override
  final Iterable<Type> types = const [
    TenantRolesListSysRoles200Response,
    _$TenantRolesListSysRoles200Response,
  ];

  @override
  final String wireName = r'TenantRolesListSysRoles200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TenantRolesListSysRoles200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(SysRole)]),
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
    TenantRolesListSysRoles200Response object, {
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
    required TenantRolesListSysRoles200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SysRole)]),
          ) as BuiltList<SysRole>;
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
  TenantRolesListSysRoles200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TenantRolesListSysRoles200ResponseBuilder();
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
