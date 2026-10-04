// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_o_auth_client_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateOAuthClientRequest extends UpdateOAuthClientRequest {
  @override
  final String? clientName;
  @override
  final String? grantTypes;
  @override
  final String? redirectUris;
  @override
  final String? scopes;
  @override
  final int? accessTokenValidity;
  @override
  final int? refreshTokenValidity;
  @override
  final bool? autoApprove;
  @override
  final int? status;

  factory _$UpdateOAuthClientRequest([
    void Function(UpdateOAuthClientRequestBuilder)? updates,
  ]) => (UpdateOAuthClientRequestBuilder()..update(updates))._build();

  _$UpdateOAuthClientRequest._({
    this.clientName,
    this.grantTypes,
    this.redirectUris,
    this.scopes,
    this.accessTokenValidity,
    this.refreshTokenValidity,
    this.autoApprove,
    this.status,
  }) : super._();
  @override
  UpdateOAuthClientRequest rebuild(
    void Function(UpdateOAuthClientRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateOAuthClientRequestBuilder toBuilder() =>
      UpdateOAuthClientRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateOAuthClientRequest &&
        clientName == other.clientName &&
        grantTypes == other.grantTypes &&
        redirectUris == other.redirectUris &&
        scopes == other.scopes &&
        accessTokenValidity == other.accessTokenValidity &&
        refreshTokenValidity == other.refreshTokenValidity &&
        autoApprove == other.autoApprove &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientName.hashCode);
    _$hash = $jc(_$hash, grantTypes.hashCode);
    _$hash = $jc(_$hash, redirectUris.hashCode);
    _$hash = $jc(_$hash, scopes.hashCode);
    _$hash = $jc(_$hash, accessTokenValidity.hashCode);
    _$hash = $jc(_$hash, refreshTokenValidity.hashCode);
    _$hash = $jc(_$hash, autoApprove.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateOAuthClientRequest')
          ..add('clientName', clientName)
          ..add('grantTypes', grantTypes)
          ..add('redirectUris', redirectUris)
          ..add('scopes', scopes)
          ..add('accessTokenValidity', accessTokenValidity)
          ..add('refreshTokenValidity', refreshTokenValidity)
          ..add('autoApprove', autoApprove)
          ..add('status', status))
        .toString();
  }
}

class UpdateOAuthClientRequestBuilder
    implements
        Builder<UpdateOAuthClientRequest, UpdateOAuthClientRequestBuilder> {
  _$UpdateOAuthClientRequest? _$v;

  String? _clientName;
  String? get clientName => _$this._clientName;
  set clientName(String? clientName) => _$this._clientName = clientName;

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

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  UpdateOAuthClientRequestBuilder() {
    UpdateOAuthClientRequest._defaults(this);
  }

  UpdateOAuthClientRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientName = $v.clientName;
      _grantTypes = $v.grantTypes;
      _redirectUris = $v.redirectUris;
      _scopes = $v.scopes;
      _accessTokenValidity = $v.accessTokenValidity;
      _refreshTokenValidity = $v.refreshTokenValidity;
      _autoApprove = $v.autoApprove;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateOAuthClientRequest other) {
    _$v = other as _$UpdateOAuthClientRequest;
  }

  @override
  void update(void Function(UpdateOAuthClientRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateOAuthClientRequest build() => _build();

  _$UpdateOAuthClientRequest _build() {
    final _$result =
        _$v ??
        _$UpdateOAuthClientRequest._(
          clientName: clientName,
          grantTypes: grantTypes,
          redirectUris: redirectUris,
          scopes: scopes,
          accessTokenValidity: accessTokenValidity,
          refreshTokenValidity: refreshTokenValidity,
          autoApprove: autoApprove,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
