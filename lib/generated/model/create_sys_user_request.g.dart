// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_sys_user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateSysUserRequest extends CreateSysUserRequest {
  @override
  final String username;
  @override
  final String password;
  @override
  final String? email;
  @override
  final String? mobile;

  factory _$CreateSysUserRequest([
    void Function(CreateSysUserRequestBuilder)? updates,
  ]) => (CreateSysUserRequestBuilder()..update(updates))._build();

  _$CreateSysUserRequest._({
    required this.username,
    required this.password,
    this.email,
    this.mobile,
  }) : super._();
  @override
  CreateSysUserRequest rebuild(
    void Function(CreateSysUserRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateSysUserRequestBuilder toBuilder() =>
      CreateSysUserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateSysUserRequest &&
        username == other.username &&
        password == other.password &&
        email == other.email &&
        mobile == other.mobile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, mobile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateSysUserRequest')
          ..add('username', username)
          ..add('password', password)
          ..add('email', email)
          ..add('mobile', mobile))
        .toString();
  }
}

class CreateSysUserRequestBuilder
    implements Builder<CreateSysUserRequest, CreateSysUserRequestBuilder> {
  _$CreateSysUserRequest? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _mobile;
  String? get mobile => _$this._mobile;
  set mobile(String? mobile) => _$this._mobile = mobile;

  CreateSysUserRequestBuilder() {
    CreateSysUserRequest._defaults(this);
  }

  CreateSysUserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _password = $v.password;
      _email = $v.email;
      _mobile = $v.mobile;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateSysUserRequest other) {
    _$v = other as _$CreateSysUserRequest;
  }

  @override
  void update(void Function(CreateSysUserRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateSysUserRequest build() => _build();

  _$CreateSysUserRequest _build() {
    final _$result =
        _$v ??
        _$CreateSysUserRequest._(
          username: BuiltValueNullFieldError.checkNotNull(
            username,
            r'CreateSysUserRequest',
            'username',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'CreateSysUserRequest',
            'password',
          ),
          email: email,
          mobile: mobile,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
