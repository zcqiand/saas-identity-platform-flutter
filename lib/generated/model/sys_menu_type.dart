//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sys_menu_type.g.dart';

class SysMenuType extends EnumClass {
  @BuiltValueEnumConst(wireName: r'directory')
  static const SysMenuType directory = _$directory;
  @BuiltValueEnumConst(wireName: r'menu')
  static const SysMenuType menu = _$menu;
  @BuiltValueEnumConst(wireName: r'button')
  static const SysMenuType button = _$button;

  static Serializer<SysMenuType> get serializer => _$sysMenuTypeSerializer;

  const SysMenuType._(String name) : super(name);

  static BuiltSet<SysMenuType> get values => _$values;
  static SysMenuType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
