// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_application.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TenantApplication extends TenantApplication {
  @override
  final String id;
  @override
  final String tenantId;
  @override
  final String clientId;
  @override
  final int status;
  @override
  final DateTime? expireTime;
  @override
  final DateTime createdAt;

  factory _$TenantApplication([
    void Function(TenantApplicationBuilder)? updates,
  ]) => (TenantApplicationBuilder()..update(updates))._build();

  _$TenantApplication._({
    required this.id,
    required this.tenantId,
    required this.clientId,
    required this.status,
    this.expireTime,
    required this.createdAt,
  }) : super._();
  @override
  TenantApplication rebuild(void Function(TenantApplicationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TenantApplicationBuilder toBuilder() =>
      TenantApplicationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TenantApplication &&
        id == other.id &&
        tenantId == other.tenantId &&
        clientId == other.clientId &&
        status == other.status &&
        expireTime == other.expireTime &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, tenantId.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, expireTime.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TenantApplication')
          ..add('id', id)
          ..add('tenantId', tenantId)
          ..add('clientId', clientId)
          ..add('status', status)
          ..add('expireTime', expireTime)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class TenantApplicationBuilder
    implements Builder<TenantApplication, TenantApplicationBuilder> {
  _$TenantApplication? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _tenantId;
  String? get tenantId => _$this._tenantId;
  set tenantId(String? tenantId) => _$this._tenantId = tenantId;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  DateTime? _expireTime;
  DateTime? get expireTime => _$this._expireTime;
  set expireTime(DateTime? expireTime) => _$this._expireTime = expireTime;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  TenantApplicationBuilder() {
    TenantApplication._defaults(this);
  }

  TenantApplicationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _tenantId = $v.tenantId;
      _clientId = $v.clientId;
      _status = $v.status;
      _expireTime = $v.expireTime;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TenantApplication other) {
    _$v = other as _$TenantApplication;
  }

  @override
  void update(void Function(TenantApplicationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TenantApplication build() => _build();

  _$TenantApplication _build() {
    final _$result =
        _$v ??
        _$TenantApplication._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'TenantApplication',
            'id',
          ),
          tenantId: BuiltValueNullFieldError.checkNotNull(
            tenantId,
            r'TenantApplication',
            'tenantId',
          ),
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'TenantApplication',
            'clientId',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'TenantApplication',
            'status',
          ),
          expireTime: expireTime,
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'TenantApplication',
            'createdAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
