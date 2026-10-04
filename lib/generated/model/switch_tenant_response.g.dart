// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_tenant_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SwitchTenantResponse extends SwitchTenantResponse {
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final DateTime expiresAt;
  @override
  final String tenantId;

  factory _$SwitchTenantResponse([
    void Function(SwitchTenantResponseBuilder)? updates,
  ]) => (SwitchTenantResponseBuilder()..update(updates))._build();

  _$SwitchTenantResponse._({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    required this.tenantId,
  }) : super._();
  @override
  SwitchTenantResponse rebuild(
    void Function(SwitchTenantResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SwitchTenantResponseBuilder toBuilder() =>
      SwitchTenantResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SwitchTenantResponse &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        expiresAt == other.expiresAt &&
        tenantId == other.tenantId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, tenantId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SwitchTenantResponse')
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('expiresAt', expiresAt)
          ..add('tenantId', tenantId))
        .toString();
  }
}

class SwitchTenantResponseBuilder
    implements Builder<SwitchTenantResponse, SwitchTenantResponseBuilder> {
  _$SwitchTenantResponse? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  String? _tenantId;
  String? get tenantId => _$this._tenantId;
  set tenantId(String? tenantId) => _$this._tenantId = tenantId;

  SwitchTenantResponseBuilder() {
    SwitchTenantResponse._defaults(this);
  }

  SwitchTenantResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _expiresAt = $v.expiresAt;
      _tenantId = $v.tenantId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SwitchTenantResponse other) {
    _$v = other as _$SwitchTenantResponse;
  }

  @override
  void update(void Function(SwitchTenantResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SwitchTenantResponse build() => _build();

  _$SwitchTenantResponse _build() {
    final _$result =
        _$v ??
        _$SwitchTenantResponse._(
          accessToken: BuiltValueNullFieldError.checkNotNull(
            accessToken,
            r'SwitchTenantResponse',
            'accessToken',
          ),
          refreshToken: BuiltValueNullFieldError.checkNotNull(
            refreshToken,
            r'SwitchTenantResponse',
            'refreshToken',
          ),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
            expiresAt,
            r'SwitchTenantResponse',
            'expiresAt',
          ),
          tenantId: BuiltValueNullFieldError.checkNotNull(
            tenantId,
            r'SwitchTenantResponse',
            'tenantId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
