// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginResponse extends LoginResponse {
  @override
  final SysUser user;
  @override
  final BuiltList<TenantMembership> availableTenants;
  @override
  final String userId;
  @override
  final String? currentTenantId;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final String? tokenType;
  @override
  final int? expiresIn;
  @override
  final String clientId;

  factory _$LoginResponse([void Function(LoginResponseBuilder)? updates]) =>
      (LoginResponseBuilder()..update(updates))._build();

  _$LoginResponse._({
    required this.user,
    required this.availableTenants,
    required this.userId,
    this.currentTenantId,
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
    required this.clientId,
  }) : super._();
  @override
  LoginResponse rebuild(void Function(LoginResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginResponseBuilder toBuilder() => LoginResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginResponse &&
        user == other.user &&
        availableTenants == other.availableTenants &&
        userId == other.userId &&
        currentTenantId == other.currentTenantId &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn &&
        clientId == other.clientId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, availableTenants.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, currentTenantId.hashCode);
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginResponse')
          ..add('user', user)
          ..add('availableTenants', availableTenants)
          ..add('userId', userId)
          ..add('currentTenantId', currentTenantId)
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn)
          ..add('clientId', clientId))
        .toString();
  }
}

class LoginResponseBuilder
    implements Builder<LoginResponse, LoginResponseBuilder> {
  _$LoginResponse? _$v;

  SysUserBuilder? _user;
  SysUserBuilder get user => _$this._user ??= SysUserBuilder();
  set user(SysUserBuilder? user) => _$this._user = user;

  ListBuilder<TenantMembership>? _availableTenants;
  ListBuilder<TenantMembership> get availableTenants =>
      _$this._availableTenants ??= ListBuilder<TenantMembership>();
  set availableTenants(ListBuilder<TenantMembership>? availableTenants) =>
      _$this._availableTenants = availableTenants;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _currentTenantId;
  String? get currentTenantId => _$this._currentTenantId;
  set currentTenantId(String? currentTenantId) =>
      _$this._currentTenantId = currentTenantId;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  String? _tokenType;
  String? get tokenType => _$this._tokenType;
  set tokenType(String? tokenType) => _$this._tokenType = tokenType;

  int? _expiresIn;
  int? get expiresIn => _$this._expiresIn;
  set expiresIn(int? expiresIn) => _$this._expiresIn = expiresIn;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  LoginResponseBuilder() {
    LoginResponse._defaults(this);
  }

  LoginResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user.toBuilder();
      _availableTenants = $v.availableTenants.toBuilder();
      _userId = $v.userId;
      _currentTenantId = $v.currentTenantId;
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _tokenType = $v.tokenType;
      _expiresIn = $v.expiresIn;
      _clientId = $v.clientId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginResponse other) {
    _$v = other as _$LoginResponse;
  }

  @override
  void update(void Function(LoginResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginResponse build() => _build();

  _$LoginResponse _build() {
    _$LoginResponse _$result;
    try {
      _$result =
          _$v ??
          _$LoginResponse._(
            user: user.build(),
            availableTenants: availableTenants.build(),
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'LoginResponse',
              'userId',
            ),
            currentTenantId: currentTenantId,
            accessToken: accessToken,
            refreshToken: refreshToken,
            tokenType: tokenType,
            expiresIn: expiresIn,
            clientId: BuiltValueNullFieldError.checkNotNull(
              clientId,
              r'LoginResponse',
              'clientId',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
        _$failedField = 'availableTenants';
        availableTenants.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LoginResponse',
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
