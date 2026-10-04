// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_menu_grant.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RoleMenuGrant extends RoleMenuGrant {
  @override
  final String roleId;
  @override
  final String tenantId;
  @override
  final BuiltList<String> menuIds;
  @override
  final DateTime updatedAt;

  factory _$RoleMenuGrant([void Function(RoleMenuGrantBuilder)? updates]) =>
      (RoleMenuGrantBuilder()..update(updates))._build();

  _$RoleMenuGrant._({
    required this.roleId,
    required this.tenantId,
    required this.menuIds,
    required this.updatedAt,
  }) : super._();
  @override
  RoleMenuGrant rebuild(void Function(RoleMenuGrantBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoleMenuGrantBuilder toBuilder() => RoleMenuGrantBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoleMenuGrant &&
        roleId == other.roleId &&
        tenantId == other.tenantId &&
        menuIds == other.menuIds &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roleId.hashCode);
    _$hash = $jc(_$hash, tenantId.hashCode);
    _$hash = $jc(_$hash, menuIds.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RoleMenuGrant')
          ..add('roleId', roleId)
          ..add('tenantId', tenantId)
          ..add('menuIds', menuIds)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class RoleMenuGrantBuilder
    implements Builder<RoleMenuGrant, RoleMenuGrantBuilder> {
  _$RoleMenuGrant? _$v;

  String? _roleId;
  String? get roleId => _$this._roleId;
  set roleId(String? roleId) => _$this._roleId = roleId;

  String? _tenantId;
  String? get tenantId => _$this._tenantId;
  set tenantId(String? tenantId) => _$this._tenantId = tenantId;

  ListBuilder<String>? _menuIds;
  ListBuilder<String> get menuIds => _$this._menuIds ??= ListBuilder<String>();
  set menuIds(ListBuilder<String>? menuIds) => _$this._menuIds = menuIds;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  RoleMenuGrantBuilder() {
    RoleMenuGrant._defaults(this);
  }

  RoleMenuGrantBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roleId = $v.roleId;
      _tenantId = $v.tenantId;
      _menuIds = $v.menuIds.toBuilder();
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RoleMenuGrant other) {
    _$v = other as _$RoleMenuGrant;
  }

  @override
  void update(void Function(RoleMenuGrantBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RoleMenuGrant build() => _build();

  _$RoleMenuGrant _build() {
    _$RoleMenuGrant _$result;
    try {
      _$result =
          _$v ??
          _$RoleMenuGrant._(
            roleId: BuiltValueNullFieldError.checkNotNull(
              roleId,
              r'RoleMenuGrant',
              'roleId',
            ),
            tenantId: BuiltValueNullFieldError.checkNotNull(
              tenantId,
              r'RoleMenuGrant',
              'tenantId',
            ),
            menuIds: menuIds.build(),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt,
              r'RoleMenuGrant',
              'updatedAt',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'menuIds';
        menuIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'RoleMenuGrant',
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
