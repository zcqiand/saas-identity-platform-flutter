// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Tenant extends Tenant {
  @override
  final String id;
  @override
  final String tenantKey;
  @override
  final String name;
  @override
  final TenantStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$Tenant([void Function(TenantBuilder)? updates]) =>
      (TenantBuilder()..update(updates))._build();

  _$Tenant._({
    required this.id,
    required this.tenantKey,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();
  @override
  Tenant rebuild(void Function(TenantBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TenantBuilder toBuilder() => TenantBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Tenant &&
        id == other.id &&
        tenantKey == other.tenantKey &&
        name == other.name &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, tenantKey.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Tenant')
          ..add('id', id)
          ..add('tenantKey', tenantKey)
          ..add('name', name)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class TenantBuilder implements Builder<Tenant, TenantBuilder> {
  _$Tenant? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _tenantKey;
  String? get tenantKey => _$this._tenantKey;
  set tenantKey(String? tenantKey) => _$this._tenantKey = tenantKey;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TenantStatus? _status;
  TenantStatus? get status => _$this._status;
  set status(TenantStatus? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  TenantBuilder() {
    Tenant._defaults(this);
  }

  TenantBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _tenantKey = $v.tenantKey;
      _name = $v.name;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Tenant other) {
    _$v = other as _$Tenant;
  }

  @override
  void update(void Function(TenantBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Tenant build() => _build();

  _$Tenant _build() {
    final _$result =
        _$v ??
        _$Tenant._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Tenant', 'id'),
          tenantKey: BuiltValueNullFieldError.checkNotNull(
            tenantKey,
            r'Tenant',
            'tenantKey',
          ),
          name: BuiltValueNullFieldError.checkNotNull(name, r'Tenant', 'name'),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'Tenant',
            'status',
          ),
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'Tenant',
            'createdAt',
          ),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
            updatedAt,
            r'Tenant',
            'updatedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
