// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_user_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SysUserStatus _$active = const SysUserStatus._('active');
const SysUserStatus _$invited = const SysUserStatus._('invited');
const SysUserStatus _$disabled = const SysUserStatus._('disabled');

SysUserStatus _$valueOf(String name) {
  switch (name) {
    case 'active':
      return _$active;
    case 'invited':
      return _$invited;
    case 'disabled':
      return _$disabled;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SysUserStatus> _$values = BuiltSet<SysUserStatus>(
  const <SysUserStatus>[_$active, _$invited, _$disabled],
);

Serializer<SysUserStatus> _$sysUserStatusSerializer =
    _$SysUserStatusSerializer();

class _$SysUserStatusSerializer implements PrimitiveSerializer<SysUserStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'active': 'active',
    'invited': 'invited',
    'disabled': 'disabled',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'active': 'active',
    'invited': 'invited',
    'disabled': 'disabled',
  };

  @override
  final Iterable<Type> types = const <Type>[SysUserStatus];
  @override
  final String wireName = 'SysUserStatus';

  @override
  Object serialize(
    Serializers serializers,
    SysUserStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SysUserStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SysUserStatus.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
