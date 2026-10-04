// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_auth_client.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OAuthClient extends OAuthClient {
  @override
  final String id;
  @override
  final String clientId;
  @override
  final String clientName;
  @override
  final String grantTypes;
  @override
  final String redirectUris;
  @override
  final String? scopes;
  @override
  final int accessTokenValidity;
  @override
  final int refreshTokenValidity;
  @override
  final bool autoApprove;
  @override
  final int status;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$OAuthClient([void Function(OAuthClientBuilder)? updates]) =>
      (OAuthClientBuilder()..update(updates))._build();

  _$OAuthClient._({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.grantTypes,
    required this.redirectUris,
    this.scopes,
    required this.accessTokenValidity,
    required this.refreshTokenValidity,
    required this.autoApprove,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();
  @override
  OAuthClient rebuild(void Function(OAuthClientBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OAuthClientBuilder toBuilder() => OAuthClientBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OAuthClient &&
        id == other.id &&
        clientId == other.clientId &&
        clientName == other.clientName &&
        grantTypes == other.grantTypes &&
        redirectUris == other.redirectUris &&
        scopes == other.scopes &&
        accessTokenValidity == other.accessTokenValidity &&
        refreshTokenValidity == other.refreshTokenValidity &&
        autoApprove == other.autoApprove &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, clientName.hashCode);
    _$hash = $jc(_$hash, grantTypes.hashCode);
    _$hash = $jc(_$hash, redirectUris.hashCode);
    _$hash = $jc(_$hash, scopes.hashCode);
    _$hash = $jc(_$hash, accessTokenValidity.hashCode);
    _$hash = $jc(_$hash, refreshTokenValidity.hashCode);
    _$hash = $jc(_$hash, autoApprove.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OAuthClient')
          ..add('id', id)
          ..add('clientId', clientId)
          ..add('clientName', clientName)
          ..add('grantTypes', grantTypes)
          ..add('redirectUris', redirectUris)
          ..add('scopes', scopes)
          ..add('accessTokenValidity', accessTokenValidity)
          ..add('refreshTokenValidity', refreshTokenValidity)
          ..add('autoApprove', autoApprove)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class OAuthClientBuilder implements Builder<OAuthClient, OAuthClientBuilder> {
  _$OAuthClient? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

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

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  OAuthClientBuilder() {
    OAuthClient._defaults(this);
  }

  OAuthClientBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _clientId = $v.clientId;
      _clientName = $v.clientName;
      _grantTypes = $v.grantTypes;
      _redirectUris = $v.redirectUris;
      _scopes = $v.scopes;
      _accessTokenValidity = $v.accessTokenValidity;
      _refreshTokenValidity = $v.refreshTokenValidity;
      _autoApprove = $v.autoApprove;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OAuthClient other) {
    _$v = other as _$OAuthClient;
  }

  @override
  void update(void Function(OAuthClientBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OAuthClient build() => _build();

  _$OAuthClient _build() {
    final _$result =
        _$v ??
        _$OAuthClient._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'OAuthClient', 'id'),
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'OAuthClient',
            'clientId',
          ),
          clientName: BuiltValueNullFieldError.checkNotNull(
            clientName,
            r'OAuthClient',
            'clientName',
          ),
          grantTypes: BuiltValueNullFieldError.checkNotNull(
            grantTypes,
            r'OAuthClient',
            'grantTypes',
          ),
          redirectUris: BuiltValueNullFieldError.checkNotNull(
            redirectUris,
            r'OAuthClient',
            'redirectUris',
          ),
          scopes: scopes,
          accessTokenValidity: BuiltValueNullFieldError.checkNotNull(
            accessTokenValidity,
            r'OAuthClient',
            'accessTokenValidity',
          ),
          refreshTokenValidity: BuiltValueNullFieldError.checkNotNull(
            refreshTokenValidity,
            r'OAuthClient',
            'refreshTokenValidity',
          ),
          autoApprove: BuiltValueNullFieldError.checkNotNull(
            autoApprove,
            r'OAuthClient',
            'autoApprove',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'OAuthClient',
            'status',
          ),
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'OAuthClient',
            'createdAt',
          ),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
            updatedAt,
            r'OAuthClient',
            'updatedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
