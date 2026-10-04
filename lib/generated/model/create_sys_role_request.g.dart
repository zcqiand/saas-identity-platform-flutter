// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_sys_role_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateSysRoleRequest extends CreateSysRoleRequest {
  @override
  final String clientId;
  @override
  final String roleCode;
  @override
  final String roleName;
  @override
  final String? description;
  @override
  final bool? isPreset;

  factory _$CreateSysRoleRequest([
    void Function(CreateSysRoleRequestBuilder)? updates,
  ]) => (CreateSysRoleRequestBuilder()..update(updates))._build();

  _$CreateSysRoleRequest._({
    required this.clientId,
    required this.roleCode,
    required this.roleName,
    this.description,
    this.isPreset,
  }) : super._();
  @override
  CreateSysRoleRequest rebuild(
    void Function(CreateSysRoleRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateSysRoleRequestBuilder toBuilder() =>
      CreateSysRoleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateSysRoleRequest &&
        clientId == other.clientId &&
        roleCode == other.roleCode &&
        roleName == other.roleName &&
        description == other.description &&
        isPreset == other.isPreset;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, roleCode.hashCode);
    _$hash = $jc(_$hash, roleName.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isPreset.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateSysRoleRequest')
          ..add('clientId', clientId)
          ..add('roleCode', roleCode)
          ..add('roleName', roleName)
          ..add('description', description)
          ..add('isPreset', isPreset))
        .toString();
  }
}

class CreateSysRoleRequestBuilder
    implements Builder<CreateSysRoleRequest, CreateSysRoleRequestBuilder> {
  _$CreateSysRoleRequest? _$v;

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

  CreateSysRoleRequestBuilder() {
    CreateSysRoleRequest._defaults(this);
  }

  CreateSysRoleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientId = $v.clientId;
      _roleCode = $v.roleCode;
      _roleName = $v.roleName;
      _description = $v.description;
      _isPreset = $v.isPreset;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateSysRoleRequest other) {
    _$v = other as _$CreateSysRoleRequest;
  }

  @override
  void update(void Function(CreateSysRoleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateSysRoleRequest build() => _build();

  _$CreateSysRoleRequest _build() {
    final _$result =
        _$v ??
        _$CreateSysRoleRequest._(
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'CreateSysRoleRequest',
            'clientId',
          ),
          roleCode: BuiltValueNullFieldError.checkNotNull(
            roleCode,
            r'CreateSysRoleRequest',
            'roleCode',
          ),
          roleName: BuiltValueNullFieldError.checkNotNull(
            roleName,
            r'CreateSysRoleRequest',
            'roleName',
          ),
          description: description,
          isPreset: isPreset,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
