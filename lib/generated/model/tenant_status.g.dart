// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TenantStatus _$active = const TenantStatus._('active');
const TenantStatus _$suspended = const TenantStatus._('suspended');

TenantStatus _$valueOf(String name) {
  switch (name) {
    case 'active':
      return _$active;
    case 'suspended':
      return _$suspended;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TenantStatus> _$values = BuiltSet<TenantStatus>(
  const <TenantStatus>[_$active, _$suspended],
);

Serializer<TenantStatus> _$tenantStatusSerializer = _$TenantStatusSerializer();

class _$TenantStatusSerializer implements PrimitiveSerializer<TenantStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'active': 'active',
    'suspended': 'suspended',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'active': 'active',
    'suspended': 'suspended',
  };

  @override
  final Iterable<Type> types = const <Type>[TenantStatus];
  @override
  final String wireName = 'TenantStatus';

  @override
  Object serialize(
    Serializers serializers,
    TenantStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TenantStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TenantStatus.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
