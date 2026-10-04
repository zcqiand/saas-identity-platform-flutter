// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_role.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SysRole extends SysRole {
  @override
  final String id;
  @override
  final String tenantId;
  @override
  final String clientId;
  @override
  final String roleCode;
  @override
  final String roleName;
  @override
  final String? description;
  @override
  final bool isPreset;
  @override
  final int status;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$SysRole([void Function(SysRoleBuilder)? updates]) =>
      (SysRoleBuilder()..update(updates))._build();

  _$SysRole._({
    required this.id,
    required this.tenantId,
    required this.clientId,
    required this.roleCode,
    required this.roleName,
    this.description,
    required this.isPreset,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();
  @override
  SysRole rebuild(void Function(SysRoleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SysRoleBuilder toBuilder() => SysRoleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SysRole &&
        id == other.id &&
        tenantId == other.tenantId &&
        clientId == other.clientId &&
        roleCode == other.roleCode &&
        roleName == other.roleName &&
        description == other.description &&
        isPreset == other.isPreset &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, tenantId.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, roleCode.hashCode);
    _$hash = $jc(_$hash, roleName.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isPreset.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SysRole')
          ..add('id', id)
          ..add('tenantId', tenantId)
          ..add('clientId', clientId)
          ..add('roleCode', roleCode)
          ..add('roleName', roleName)
          ..add('description', description)
          ..add('isPreset', isPreset)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class SysRoleBuilder implements Builder<SysRole, SysRoleBuilder> {
  _$SysRole? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _tenantId;
  String? get tenantId => _$this._tenantId;
  set tenantId(String? tenantId) => _$this._tenantId = tenantId;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _roleCode;
  String? get roleCode => _$this._roleCode;
  set roleCode(String? roleCode) => _$this._roleCode = roleCode;

  String? _roleName;
  String? get roleName => _$this._roleName;
  set roleName(String? roleName) => _$this._roleName = roleName;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _isPreset;
  bool? get isPreset => _$this._isPreset;
  set isPreset(bool? isPreset) => _$this._isPreset = isPreset;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  SysRoleBuilder() {
    SysRole._defaults(this);
  }

  SysRoleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _tenantId = $v.tenantId;
      _clientId = $v.clientId;
      _roleCode = $v.roleCode;
      _roleName = $v.roleName;
      _description = $v.description;
      _isPreset = $v.isPreset;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SysRole other) {
    _$v = other as _$SysRole;
  }

  @override
  void update(void Function(SysRoleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SysRole build() => _build();

  _$SysRole _build() {
    final _$result =
        _$v ??
        _$SysRole._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'SysRole', 'id'),
          tenantId: BuiltValueNullFieldError.checkNotNull(
            tenantId,
            r'SysRole',
            'tenantId',
          ),
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'SysRole',
            'clientId',
          ),
          roleCode: BuiltValueNullFieldError.checkNotNull(
            roleCode,
            r'SysRole',
            'roleCode',
          ),
          roleName: BuiltValueNullFieldError.checkNotNull(
            roleName,
            r'SysRole',
            'roleName',
          ),
          description: description,
          isPreset: BuiltValueNullFieldError.checkNotNull(
            isPreset,
            r'SysRole',
            'isPreset',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'SysRole',
            'status',
          ),
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'SysRole',
            'createdAt',
          ),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
            updatedAt,
            r'SysRole',
            'updatedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
