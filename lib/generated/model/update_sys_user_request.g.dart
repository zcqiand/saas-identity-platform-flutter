// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_sys_user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateSysUserRequest extends UpdateSysUserRequest {
  @override
  final String? email;
  @override
  final String? mobile;

  factory _$UpdateSysUserRequest([
    void Function(UpdateSysUserRequestBuilder)? updates,
  ]) => (UpdateSysUserRequestBuilder()..update(updates))._build();

  _$UpdateSysUserRequest._({this.email, this.mobile}) : super._();
  @override
  UpdateSysUserRequest rebuild(
    void Function(UpdateSysUserRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateSysUserRequestBuilder toBuilder() =>
      UpdateSysUserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateSysUserRequest &&
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
    return (newBuiltValueToStringHelper(r'UpdateSysUserRequest')
          ..add('email', email)
          ..add('mobile', mobile))
        .toString();
  }
}

class UpdateSysUserRequestBuilder
    implements Builder<UpdateSysUserRequest, UpdateSysUserRequestBuilder> {
  _$UpdateSysUserRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _mobile;
  String? get mobile => _$this._mobile;
  set mobile(String? mobile) => _$this._mobile = mobile;

  UpdateSysUserRequestBuilder() {
    UpdateSysUserRequest._defaults(this);
  }

  UpdateSysUserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _mobile = $v.mobile;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateSysUserRequest other) {
    _$v = other as _$UpdateSysUserRequest;
  }

  @override
  void update(void Function(UpdateSysUserRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateSysUserRequest build() => _build();

  _$UpdateSysUserRequest _build() {
    final _$result =
        _$v ?? _$UpdateSysUserRequest._(email: email, mobile: mobile);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
