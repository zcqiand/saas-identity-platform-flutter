// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_tenant_member_roles_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetTenantMemberRolesRequest extends SetTenantMemberRolesRequest {
  @override
  final BuiltList<String> roleIds;

  factory _$SetTenantMemberRolesRequest([
    void Function(SetTenantMemberRolesRequestBuilder)? updates,
  ]) => (SetTenantMemberRolesRequestBuilder()..update(updates))._build();

  _$SetTenantMemberRolesRequest._({required this.roleIds}) : super._();
  @override
  SetTenantMemberRolesRequest rebuild(
    void Function(SetTenantMemberRolesRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SetTenantMemberRolesRequestBuilder toBuilder() =>
      SetTenantMemberRolesRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetTenantMemberRolesRequest && roleIds == other.roleIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roleIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SetTenantMemberRolesRequest',
    )..add('roleIds', roleIds)).toString();
  }
}

class SetTenantMemberRolesRequestBuilder
    implements
        Builder<
          SetTenantMemberRolesRequest,
          SetTenantMemberRolesRequestBuilder
        > {
  _$SetTenantMemberRolesRequest? _$v;

  ListBuilder<String>? _roleIds;
  ListBuilder<String> get roleIds => _$this._roleIds ??= ListBuilder<String>();
  set roleIds(ListBuilder<String>? roleIds) => _$this._roleIds = roleIds;

  SetTenantMemberRolesRequestBuilder() {
    SetTenantMemberRolesRequest._defaults(this);
  }

  SetTenantMemberRolesRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roleIds = $v.roleIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetTenantMemberRolesRequest other) {
    _$v = other as _$SetTenantMemberRolesRequest;
  }

  @override
  void update(void Function(SetTenantMemberRolesRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetTenantMemberRolesRequest build() => _build();

  _$SetTenantMemberRolesRequest _build() {
    _$SetTenantMemberRolesRequest _$result;
    try {
      _$result =
          _$v ?? _$SetTenantMemberRolesRequest._(roleIds: roleIds.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'roleIds';
        roleIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SetTenantMemberRolesRequest',
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
