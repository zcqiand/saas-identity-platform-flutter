// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_member_view.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TenantMemberView extends TenantMemberView {
  @override
  final TenantMember member;
  @override
  final SysUser user;
  @override
  final BuiltList<String> roles;

  factory _$TenantMemberView([
    void Function(TenantMemberViewBuilder)? updates,
  ]) => (TenantMemberViewBuilder()..update(updates))._build();

  _$TenantMemberView._({
    required this.member,
    required this.user,
    required this.roles,
  }) : super._();
  @override
  TenantMemberView rebuild(void Function(TenantMemberViewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TenantMemberViewBuilder toBuilder() =>
      TenantMemberViewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TenantMemberView &&
        member == other.member &&
        user == other.user &&
        roles == other.roles;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, member.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, roles.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TenantMemberView')
          ..add('member', member)
          ..add('user', user)
          ..add('roles', roles))
        .toString();
  }
}

class TenantMemberViewBuilder
    implements Builder<TenantMemberView, TenantMemberViewBuilder> {
  _$TenantMemberView? _$v;

  TenantMemberBuilder? _member;
  TenantMemberBuilder get member => _$this._member ??= TenantMemberBuilder();
  set member(TenantMemberBuilder? member) => _$this._member = member;

  SysUserBuilder? _user;
  SysUserBuilder get user => _$this._user ??= SysUserBuilder();
  set user(SysUserBuilder? user) => _$this._user = user;

  ListBuilder<String>? _roles;
  ListBuilder<String> get roles => _$this._roles ??= ListBuilder<String>();
  set roles(ListBuilder<String>? roles) => _$this._roles = roles;

  TenantMemberViewBuilder() {
    TenantMemberView._defaults(this);
  }

  TenantMemberViewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _member = $v.member.toBuilder();
      _user = $v.user.toBuilder();
      _roles = $v.roles.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TenantMemberView other) {
    _$v = other as _$TenantMemberView;
  }

  @override
  void update(void Function(TenantMemberViewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TenantMemberView build() => _build();

  _$TenantMemberView _build() {
    _$TenantMemberView _$result;
    try {
      _$result =
          _$v ??
          _$TenantMemberView._(
            member: member.build(),
            user: user.build(),
            roles: roles.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'member';
        member.build();
        _$failedField = 'user';
        user.build();
        _$failedField = 'roles';
        roles.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TenantMemberView',
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
