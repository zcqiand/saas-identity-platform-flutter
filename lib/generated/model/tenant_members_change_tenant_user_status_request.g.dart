// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_members_change_tenant_user_status_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TenantMembersChangeTenantUserStatusRequest
    extends TenantMembersChangeTenantUserStatusRequest {
  @override
  final TenantMemberStatus status;

  factory _$TenantMembersChangeTenantUserStatusRequest([
    void Function(TenantMembersChangeTenantUserStatusRequestBuilder)? updates,
  ]) => (TenantMembersChangeTenantUserStatusRequestBuilder()..update(updates))
      ._build();

  _$TenantMembersChangeTenantUserStatusRequest._({required this.status})
    : super._();
  @override
  TenantMembersChangeTenantUserStatusRequest rebuild(
    void Function(TenantMembersChangeTenantUserStatusRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TenantMembersChangeTenantUserStatusRequestBuilder toBuilder() =>
      TenantMembersChangeTenantUserStatusRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TenantMembersChangeTenantUserStatusRequest &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'TenantMembersChangeTenantUserStatusRequest',
    )..add('status', status)).toString();
  }
}

class TenantMembersChangeTenantUserStatusRequestBuilder
    implements
        Builder<
          TenantMembersChangeTenantUserStatusRequest,
          TenantMembersChangeTenantUserStatusRequestBuilder
        > {
  _$TenantMembersChangeTenantUserStatusRequest? _$v;

  TenantMemberStatus? _status;
  TenantMemberStatus? get status => _$this._status;
  set status(TenantMemberStatus? status) => _$this._status = status;

  TenantMembersChangeTenantUserStatusRequestBuilder() {
    TenantMembersChangeTenantUserStatusRequest._defaults(this);
  }

  TenantMembersChangeTenantUserStatusRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TenantMembersChangeTenantUserStatusRequest other) {
    _$v = other as _$TenantMembersChangeTenantUserStatusRequest;
  }

  @override
  void update(
    void Function(TenantMembersChangeTenantUserStatusRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TenantMembersChangeTenantUserStatusRequest build() => _build();

  _$TenantMembersChangeTenantUserStatusRequest _build() {
    final _$result =
        _$v ??
        _$TenantMembersChangeTenantUserStatusRequest._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'TenantMembersChangeTenantUserStatusRequest',
            'status',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
