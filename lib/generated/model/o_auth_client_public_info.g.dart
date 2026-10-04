// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_auth_client_public_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OAuthClientPublicInfo extends OAuthClientPublicInfo {
  @override
  final String clientId;
  @override
  final String clientName;
  @override
  final int status;

  factory _$OAuthClientPublicInfo([
    void Function(OAuthClientPublicInfoBuilder)? updates,
  ]) => (OAuthClientPublicInfoBuilder()..update(updates))._build();

  _$OAuthClientPublicInfo._({
    required this.clientId,
    required this.clientName,
    required this.status,
  }) : super._();
  @override
  OAuthClientPublicInfo rebuild(
    void Function(OAuthClientPublicInfoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OAuthClientPublicInfoBuilder toBuilder() =>
      OAuthClientPublicInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OAuthClientPublicInfo &&
        clientId == other.clientId &&
        clientName == other.clientName &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, clientName.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OAuthClientPublicInfo')
          ..add('clientId', clientId)
          ..add('clientName', clientName)
          ..add('status', status))
        .toString();
  }
}

class OAuthClientPublicInfoBuilder
    implements Builder<OAuthClientPublicInfo, OAuthClientPublicInfoBuilder> {
  _$OAuthClientPublicInfo? _$v;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _clientName;
  String? get clientName => _$this._clientName;
  set clientName(String? clientName) => _$this._clientName = clientName;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  OAuthClientPublicInfoBuilder() {
    OAuthClientPublicInfo._defaults(this);
  }

  OAuthClientPublicInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientId = $v.clientId;
      _clientName = $v.clientName;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OAuthClientPublicInfo other) {
    _$v = other as _$OAuthClientPublicInfo;
  }

  @override
  void update(void Function(OAuthClientPublicInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OAuthClientPublicInfo build() => _build();

  _$OAuthClientPublicInfo _build() {
    final _$result =
        _$v ??
        _$OAuthClientPublicInfo._(
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'OAuthClientPublicInfo',
            'clientId',
          ),
          clientName: BuiltValueNullFieldError.checkNotNull(
            clientName,
            r'OAuthClientPublicInfo',
            'clientName',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'OAuthClientPublicInfo',
            'status',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
