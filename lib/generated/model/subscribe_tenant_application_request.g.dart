// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribe_tenant_application_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubscribeTenantApplicationRequest
    extends SubscribeTenantApplicationRequest {
  @override
  final String clientId;
  @override
  final DateTime? expireTime;

  factory _$SubscribeTenantApplicationRequest([
    void Function(SubscribeTenantApplicationRequestBuilder)? updates,
  ]) => (SubscribeTenantApplicationRequestBuilder()..update(updates))._build();

  _$SubscribeTenantApplicationRequest._({
    required this.clientId,
    this.expireTime,
  }) : super._();
  @override
  SubscribeTenantApplicationRequest rebuild(
    void Function(SubscribeTenantApplicationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SubscribeTenantApplicationRequestBuilder toBuilder() =>
      SubscribeTenantApplicationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscribeTenantApplicationRequest &&
        clientId == other.clientId &&
        expireTime == other.expireTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, expireTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubscribeTenantApplicationRequest')
          ..add('clientId', clientId)
          ..add('expireTime', expireTime))
        .toString();
  }
}

class SubscribeTenantApplicationRequestBuilder
    implements
        Builder<
          SubscribeTenantApplicationRequest,
          SubscribeTenantApplicationRequestBuilder
        > {
  _$SubscribeTenantApplicationRequest? _$v;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  DateTime? _expireTime;
  DateTime? get expireTime => _$this._expireTime;
  set expireTime(DateTime? expireTime) => _$this._expireTime = expireTime;

  SubscribeTenantApplicationRequestBuilder() {
    SubscribeTenantApplicationRequest._defaults(this);
  }

  SubscribeTenantApplicationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientId = $v.clientId;
      _expireTime = $v.expireTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscribeTenantApplicationRequest other) {
    _$v = other as _$SubscribeTenantApplicationRequest;
  }

  @override
  void update(
    void Function(SubscribeTenantApplicationRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  SubscribeTenantApplicationRequest build() => _build();

  _$SubscribeTenantApplicationRequest _build() {
    final _$result =
        _$v ??
        _$SubscribeTenantApplicationRequest._(
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'SubscribeTenantApplicationRequest',
            'clientId',
          ),
          expireTime: expireTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
