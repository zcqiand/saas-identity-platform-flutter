// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginRequest extends LoginRequest {
  @override
  final String username;
  @override
  final String password;
  @override
  final String clientId;

  factory _$LoginRequest([void Function(LoginRequestBuilder)? updates]) =>
      (LoginRequestBuilder()..update(updates))._build();

  _$LoginRequest._({
    required this.username,
    required this.password,
    required this.clientId,
  }) : super._();
  @override
  LoginRequest rebuild(void Function(LoginRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginRequestBuilder toBuilder() => LoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginRequest &&
        username == other.username &&
        password == other.password &&
        clientId == other.clientId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginRequest')
          ..add('username', username)
          ..add('password', password)
          ..add('clientId', clientId))
        .toString();
  }
}

class LoginRequestBuilder
    implements Builder<LoginRequest, LoginRequestBuilder> {
  _$LoginRequest? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  LoginRequestBuilder() {
    LoginRequest._defaults(this);
  }

  LoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _password = $v.password;
      _clientId = $v.clientId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginRequest other) {
    _$v = other as _$LoginRequest;
  }

  @override
  void update(void Function(LoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginRequest build() => _build();

  _$LoginRequest _build() {
    final _$result =
        _$v ??
        _$LoginRequest._(
          username: BuiltValueNullFieldError.checkNotNull(
            username,
            r'LoginRequest',
            'username',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'LoginRequest',
            'password',
          ),
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'LoginRequest',
            'clientId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
