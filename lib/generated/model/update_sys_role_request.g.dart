// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_sys_role_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateSysRoleRequest extends UpdateSysRoleRequest {
  @override
  final String? roleName;
  @override
  final String? description;
  @override
  final int? status;

  factory _$UpdateSysRoleRequest([
    void Function(UpdateSysRoleRequestBuilder)? updates,
  ]) => (UpdateSysRoleRequestBuilder()..update(updates))._build();

  _$UpdateSysRoleRequest._({this.roleName, this.description, this.status})
    : super._();
  @override
  UpdateSysRoleRequest rebuild(
    void Function(UpdateSysRoleRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateSysRoleRequestBuilder toBuilder() =>
      UpdateSysRoleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateSysRoleRequest &&
        roleName == other.roleName &&
        description == other.description &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roleName.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateSysRoleRequest')
          ..add('roleName', roleName)
          ..add('description', description)
          ..add('status', status))
        .toString();
  }
}

class UpdateSysRoleRequestBuilder
    implements Builder<UpdateSysRoleRequest, UpdateSysRoleRequestBuilder> {
  _$UpdateSysRoleRequest? _$v;

  String? _roleName;
  String? get roleName => _$this._roleName;
  set roleName(String? roleName) => _$this._roleName = roleName;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  UpdateSysRoleRequestBuilder() {
    UpdateSysRoleRequest._defaults(this);
  }

  UpdateSysRoleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roleName = $v.roleName;
      _description = $v.description;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateSysRoleRequest other) {
    _$v = other as _$UpdateSysRoleRequest;
  }

  @override
  void update(void Function(UpdateSysRoleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateSysRoleRequest build() => _build();

  _$UpdateSysRoleRequest _build() {
    final _$result =
        _$v ??
        _$UpdateSysRoleRequest._(
          roleName: roleName,
          description: description,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
