// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_menu_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SysMenuType _$directory = const SysMenuType._('directory');
const SysMenuType _$menu = const SysMenuType._('menu');
const SysMenuType _$button = const SysMenuType._('button');

SysMenuType _$valueOf(String name) {
  switch (name) {
    case 'directory':
      return _$directory;
    case 'menu':
      return _$menu;
    case 'button':
      return _$button;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SysMenuType> _$values = BuiltSet<SysMenuType>(
  const <SysMenuType>[_$directory, _$menu, _$button],
);

Serializer<SysMenuType> _$sysMenuTypeSerializer = _$SysMenuTypeSerializer();

class _$SysMenuTypeSerializer implements PrimitiveSerializer<SysMenuType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'directory': 'directory',
    'menu': 'menu',
    'button': 'button',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'directory': 'directory',
    'menu': 'menu',
    'button': 'button',
  };

  @override
  final Iterable<Type> types = const <Type>[SysMenuType];
  @override
  final String wireName = 'SysMenuType';

  @override
  Object serialize(
    Serializers serializers,
    SysMenuType object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SysMenuType deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SysMenuType.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
