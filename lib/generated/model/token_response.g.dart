// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TokenResponse extends TokenResponse {
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final String tokenType;
  @override
  final int expiresIn;
  @override
  final String? scope;
  @override
  final String userId;
  @override
  final String clientId;
  @override
  final String tenantId;

  factory _$TokenResponse([void Function(TokenResponseBuilder)? updates]) =>
      (TokenResponseBuilder()..update(updates))._build();

  _$TokenResponse._({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    this.scope,
    required this.userId,
    required this.clientId,
    required this.tenantId,
  }) : super._();
  @override
  TokenResponse rebuild(void Function(TokenResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenResponseBuilder toBuilder() => TokenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenResponse &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn &&
        scope == other.scope &&
        userId == other.userId &&
        clientId == other.clientId &&
        tenantId == other.tenantId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, tenantId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TokenResponse')
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn)
          ..add('scope', scope)
          ..add('userId', userId)
          ..add('clientId', clientId)
          ..add('tenantId', tenantId))
        .toString();
  }
}

class TokenResponseBuilder
    implements Builder<TokenResponse, TokenResponseBuilder> {
  _$TokenResponse? _$v;

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

  String? _scope;
  String? get scope => _$this._scope;
  set scope(String? scope) => _$this._scope = scope;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _tenantId;
  String? get tenantId => _$this._tenantId;
  set tenantId(String? tenantId) => _$this._tenantId = tenantId;

  TokenResponseBuilder() {
    TokenResponse._defaults(this);
  }

  TokenResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _tokenType = $v.tokenType;
      _expiresIn = $v.expiresIn;
      _scope = $v.scope;
      _userId = $v.userId;
      _clientId = $v.clientId;
      _tenantId = $v.tenantId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenResponse other) {
    _$v = other as _$TokenResponse;
  }

  @override
  void update(void Function(TokenResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TokenResponse build() => _build();

  _$TokenResponse _build() {
    final _$result =
        _$v ??
        _$TokenResponse._(
          accessToken: BuiltValueNullFieldError.checkNotNull(
            accessToken,
            r'TokenResponse',
            'accessToken',
          ),
          refreshToken: BuiltValueNullFieldError.checkNotNull(
            refreshToken,
            r'TokenResponse',
            'refreshToken',
          ),
          tokenType: BuiltValueNullFieldError.checkNotNull(
            tokenType,
            r'TokenResponse',
            'tokenType',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'TokenResponse',
            'expiresIn',
          ),
          scope: scope,
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'TokenResponse',
            'userId',
          ),
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'TokenResponse',
            'clientId',
          ),
          tenantId: BuiltValueNullFieldError.checkNotNull(
            tenantId,
            r'TokenResponse',
            'tenantId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
