//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sys_user_status.g.dart';

class SysUserStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: r'active')
  static const SysUserStatus active = _$active;
  @BuiltValueEnumConst(wireName: r'invited')
  static const SysUserStatus invited = _$invited;
  @BuiltValueEnumConst(wireName: r'disabled')
  static const SysUserStatus disabled = _$disabled;

  static Serializer<SysUserStatus> get serializer => _$sysUserStatusSerializer;

  const SysUserStatus._(String name) : super(name);

  static BuiltSet<SysUserStatus> get values => _$values;
  static SysUserStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
