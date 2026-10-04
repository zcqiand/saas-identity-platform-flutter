// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_o_auth_client_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateOAuthClientRequest extends CreateOAuthClientRequest {
  @override
  final String clientId;
  @override
  final String clientName;
  @override
  final String clientSecret;
  @override
  final String grantTypes;
  @override
  final String redirectUris;
  @override
  final String? scopes;
  @override
  final int? accessTokenValidity;
  @override
  final int? refreshTokenValidity;
  @override
  final bool? autoApprove;

  factory _$CreateOAuthClientRequest([
    void Function(CreateOAuthClientRequestBuilder)? updates,
  ]) => (CreateOAuthClientRequestBuilder()..update(updates))._build();

  _$CreateOAuthClientRequest._({
    required this.clientId,
    required this.clientName,
    required this.clientSecret,
    required this.grantTypes,
    required this.redirectUris,
    this.scopes,
    this.accessTokenValidity,
    this.refreshTokenValidity,
    this.autoApprove,
  }) : super._();
  @override
  CreateOAuthClientRequest rebuild(
    void Function(CreateOAuthClientRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateOAuthClientRequestBuilder toBuilder() =>
      CreateOAuthClientRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateOAuthClientRequest &&
        clientId == other.clientId &&
        clientName == other.clientName &&
        clientSecret == other.clientSecret &&
        grantTypes == other.grantTypes &&
        redirectUris == other.redirectUris &&
        scopes == other.scopes &&
        accessTokenValidity == other.accessTokenValidity &&
        refreshTokenValidity == other.refreshTokenValidity &&
        autoApprove == other.autoApprove;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, clientName.hashCode);
    _$hash = $jc(_$hash, clientSecret.hashCode);
    _$hash = $jc(_$hash, grantTypes.hashCode);
    _$hash = $jc(_$hash, redirectUris.hashCode);
    _$hash = $jc(_$hash, scopes.hashCode);
    _$hash = $jc(_$hash, accessTokenValidity.hashCode);
    _$hash = $jc(_$hash, refreshTokenValidity.hashCode);
    _$hash = $jc(_$hash, autoApprove.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateOAuthClientRequest')
          ..add('clientId', clientId)
          ..add('clientName', clientName)
          ..add('clientSecret', clientSecret)
          ..add('grantTypes', grantTypes)
          ..add('redirectUris', redirectUris)
          ..add('scopes', scopes)
          ..add('accessTokenValidity', accessTokenValidity)
          ..add('refreshTokenValidity', refreshTokenValidity)
          ..add('autoApprove', autoApprove))
        .toString();
  }
}

class CreateOAuthClientRequestBuilder
    implements
        Builder<CreateOAuthClientRequest, CreateOAuthClientRequestBuilder> {
  _$CreateOAuthClientRequest? _$v;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _clientName;
  String? get clientName => _$this._clientName;
  set clientName(String? clientName) => _$this._clientName = clientName;

  String? _clientSecret;
  String? get clientSecret => _$this._clientSecret;
  set clientSecret(String? clientSecret) => _$this._clientSecret = clientSecret;

  String? _grantTypes;
  String? get grantTypes => _$this._grantTypes;
  set grantTypes(String? grantTypes) => _$this._grantTypes = grantTypes;

  String? _redirectUris;
  String? get redirectUris => _$this._redirectUris;
  set redirectUris(String? redirectUris) => _$this._redirectUris = redirectUris;

  String? _scopes;
  String? get scopes => _$this._scopes;
  set scopes(String? scopes) => _$this._scopes = scopes;

  int? _accessTokenValidity;
  int? get accessTokenValidity => _$this._accessTokenValidity;
  set accessTokenValidity(int? accessTokenValidity) =>
      _$this._accessTokenValidity = accessTokenValidity;

  int? _refreshTokenValidity;
  int? get refreshTokenValidity => _$this._refreshTokenValidity;
  set refreshTokenValidity(int? refreshTokenValidity) =>
      _$this._refreshTokenValidity = refreshTokenValidity;

  bool? _autoApprove;
  bool? get autoApprove => _$this._autoApprove;
  set autoApprove(bool? autoApprove) => _$this._autoApprove = autoApprove;

  CreateOAuthClientRequestBuilder() {
    CreateOAuthClientRequest._defaults(this);
  }

  CreateOAuthClientRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientId = $v.clientId;
      _clientName = $v.clientName;
      _clientSecret = $v.clientSecret;
      _grantTypes = $v.grantTypes;
      _redirectUris = $v.redirectUris;
      _scopes = $v.scopes;
      _accessTokenValidity = $v.accessTokenValidity;
      _refreshTokenValidity = $v.refreshTokenValidity;
      _autoApprove = $v.autoApprove;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateOAuthClientRequest other) {
    _$v = other as _$CreateOAuthClientRequest;
  }

  @override
  void update(void Function(CreateOAuthClientRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateOAuthClientRequest build() => _build();

  _$CreateOAuthClientRequest _build() {
    final _$result =
        _$v ??
        _$CreateOAuthClientRequest._(
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'CreateOAuthClientRequest',
            'clientId',
          ),
          clientName: BuiltValueNullFieldError.checkNotNull(
            clientName,
            r'CreateOAuthClientRequest',
            'clientName',
          ),
          clientSecret: BuiltValueNullFieldError.checkNotNull(
            clientSecret,
            r'CreateOAuthClientRequest',
            'clientSecret',
          ),
          grantTypes: BuiltValueNullFieldError.checkNotNull(
            grantTypes,
            r'CreateOAuthClientRequest',
            'grantTypes',
          ),
          redirectUris: BuiltValueNullFieldError.checkNotNull(
            redirectUris,
            r'CreateOAuthClientRequest',
            'redirectUris',
          ),
          scopes: scopes,
          accessTokenValidity: accessTokenValidity,
          refreshTokenValidity: refreshTokenValidity,
          autoApprove: autoApprove,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
