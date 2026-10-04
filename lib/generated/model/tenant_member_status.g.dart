// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_member_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TenantMemberStatus _$active = const TenantMemberStatus._('active');
const TenantMemberStatus _$invited = const TenantMemberStatus._('invited');
const TenantMemberStatus _$suspended = const TenantMemberStatus._('suspended');
const TenantMemberStatus _$disabled = const TenantMemberStatus._('disabled');

TenantMemberStatus _$valueOf(String name) {
  switch (name) {
    case 'active':
      return _$active;
    case 'invited':
      return _$invited;
    case 'suspended':
      return _$suspended;
    case 'disabled':
      return _$disabled;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TenantMemberStatus> _$values = BuiltSet<TenantMemberStatus>(
  const <TenantMemberStatus>[_$active, _$invited, _$suspended, _$disabled],
);

Serializer<TenantMemberStatus> _$tenantMemberStatusSerializer =
    _$TenantMemberStatusSerializer();

class _$TenantMemberStatusSerializer
    implements PrimitiveSerializer<TenantMemberStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'active': 'active',
    'invited': 'invited',
    'suspended': 'suspended',
    'disabled': 'disabled',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'active': 'active',
    'invited': 'invited',
    'suspended': 'suspended',
    'disabled': 'disabled',
  };

  @override
  final Iterable<Type> types = const <Type>[TenantMemberStatus];
  @override
  final String wireName = 'TenantMemberStatus';

  @override
  Object serialize(
    Serializers serializers,
    TenantMemberStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TenantMemberStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TenantMemberStatus.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
