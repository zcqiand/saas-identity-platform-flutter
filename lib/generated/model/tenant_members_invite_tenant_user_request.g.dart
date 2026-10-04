// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_members_invite_tenant_user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TenantMembersInviteTenantUserRequest
    extends TenantMembersInviteTenantUserRequest {
  @override
  final String? email;
  @override
  final String? mobile;

  factory _$TenantMembersInviteTenantUserRequest([
    void Function(TenantMembersInviteTenantUserRequestBuilder)? updates,
  ]) =>
      (TenantMembersInviteTenantUserRequestBuilder()..update(updates))._build();

  _$TenantMembersInviteTenantUserRequest._({this.email, this.mobile})
    : super._();
  @override
  TenantMembersInviteTenantUserRequest rebuild(
    void Function(TenantMembersInviteTenantUserRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TenantMembersInviteTenantUserRequestBuilder toBuilder() =>
      TenantMembersInviteTenantUserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TenantMembersInviteTenantUserRequest &&
        email == other.email &&
        mobile == other.mobile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, mobile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TenantMembersInviteTenantUserRequest')
          ..add('email', email)
          ..add('mobile', mobile))
        .toString();
  }
}

class TenantMembersInviteTenantUserRequestBuilder
    implements
        Builder<
          TenantMembersInviteTenantUserRequest,
          TenantMembersInviteTenantUserRequestBuilder
        > {
  _$TenantMembersInviteTenantUserRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _mobile;
  String? get mobile => _$this._mobile;
  set mobile(String? mobile) => _$this._mobile = mobile;

  TenantMembersInviteTenantUserRequestBuilder() {
    TenantMembersInviteTenantUserRequest._defaults(this);
  }

  TenantMembersInviteTenantUserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _mobile = $v.mobile;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TenantMembersInviteTenantUserRequest other) {
    _$v = other as _$TenantMembersInviteTenantUserRequest;
  }

  @override
  void update(
    void Function(TenantMembersInviteTenantUserRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TenantMembersInviteTenantUserRequest build() => _build();

  _$TenantMembersInviteTenantUserRequest _build() {
    final _$result =
        _$v ??
        _$TenantMembersInviteTenantUserRequest._(email: email, mobile: mobile);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
