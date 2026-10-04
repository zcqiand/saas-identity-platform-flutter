//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:saas_identity_platform_flutter/generated/model/sys_user.dart';
import 'package:saas_identity_platform_flutter/generated/model/tenant_member.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tenant_member_view.g.dart';

/// TenantMemberView
///
/// Properties:
/// * [member]
/// * [user]
/// * [roles]
@BuiltValue()
abstract class TenantMemberView
    implements Built<TenantMemberView, TenantMemberViewBuilder> {
  @BuiltValueField(wireName: r'member')
  TenantMember get member;

  @BuiltValueField(wireName: r'user')
  SysUser get user;

  @BuiltValueField(wireName: r'roles')
  BuiltList<String> get roles;

  TenantMemberView._();

  factory TenantMemberView([void updates(TenantMemberViewBuilder b)]) =
      _$TenantMemberView;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TenantMemberViewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TenantMemberView> get serializer =>
      _$TenantMemberViewSerializer();
}

class _$TenantMemberViewSerializer
    implements PrimitiveSerializer<TenantMemberView> {
  @override
  final Iterable<Type> types = const [TenantMemberView, _$TenantMemberView];

  @override
  final String wireName = r'TenantMemberView';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TenantMemberView object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'member';
    yield serializers.serialize(
      object.member,
      specifiedType: const FullType(TenantMember),
    );
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(SysUser),
    );
    yield r'roles';
    yield serializers.serialize(
      object.roles,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TenantMemberView object, {
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
    required TenantMemberViewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'member':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TenantMember),
          ) as TenantMember;
          result.member.replace(valueDes);
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SysUser),
          ) as SysUser;
          result.user.replace(valueDes);
          break;
        case r'roles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.roles.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TenantMemberView deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TenantMemberViewBuilder();
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
