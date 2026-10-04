// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_sys_role_menus_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetSysRoleMenusRequest extends SetSysRoleMenusRequest {
  @override
  final BuiltList<String> menuIds;

  factory _$SetSysRoleMenusRequest([
    void Function(SetSysRoleMenusRequestBuilder)? updates,
  ]) => (SetSysRoleMenusRequestBuilder()..update(updates))._build();

  _$SetSysRoleMenusRequest._({required this.menuIds}) : super._();
  @override
  SetSysRoleMenusRequest rebuild(
    void Function(SetSysRoleMenusRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SetSysRoleMenusRequestBuilder toBuilder() =>
      SetSysRoleMenusRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetSysRoleMenusRequest && menuIds == other.menuIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, menuIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SetSysRoleMenusRequest',
    )..add('menuIds', menuIds)).toString();
  }
}

class SetSysRoleMenusRequestBuilder
    implements Builder<SetSysRoleMenusRequest, SetSysRoleMenusRequestBuilder> {
  _$SetSysRoleMenusRequest? _$v;

  ListBuilder<String>? _menuIds;
  ListBuilder<String> get menuIds => _$this._menuIds ??= ListBuilder<String>();
  set menuIds(ListBuilder<String>? menuIds) => _$this._menuIds = menuIds;

  SetSysRoleMenusRequestBuilder() {
    SetSysRoleMenusRequest._defaults(this);
  }

  SetSysRoleMenusRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _menuIds = $v.menuIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetSysRoleMenusRequest other) {
    _$v = other as _$SetSysRoleMenusRequest;
  }

  @override
  void update(void Function(SetSysRoleMenusRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetSysRoleMenusRequest build() => _build();

  _$SetSysRoleMenusRequest _build() {
    _$SetSysRoleMenusRequest _$result;
    try {
      _$result = _$v ?? _$SetSysRoleMenusRequest._(menuIds: menuIds.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'menuIds';
        menuIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SetSysRoleMenusRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
