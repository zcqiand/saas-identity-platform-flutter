// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_tenant_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateTenantRequest extends CreateTenantRequest {
  @override
  final String tenantKey;
  @override
  final String name;

  factory _$CreateTenantRequest([
    void Function(CreateTenantRequestBuilder)? updates,
  ]) => (CreateTenantRequestBuilder()..update(updates))._build();

  _$CreateTenantRequest._({required this.tenantKey, required this.name})
    : super._();
  @override
  CreateTenantRequest rebuild(
    void Function(CreateTenantRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateTenantRequestBuilder toBuilder() =>
      CreateTenantRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateTenantRequest &&
        tenantKey == other.tenantKey &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tenantKey.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateTenantRequest')
          ..add('tenantKey', tenantKey)
          ..add('name', name))
        .toString();
  }
}

class CreateTenantRequestBuilder
    implements Builder<CreateTenantRequest, CreateTenantRequestBuilder> {
  _$CreateTenantRequest? _$v;

  String? _tenantKey;
  String? get tenantKey => _$this._tenantKey;
  set tenantKey(String? tenantKey) => _$this._tenantKey = tenantKey;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CreateTenantRequestBuilder() {
    CreateTenantRequest._defaults(this);
  }

  CreateTenantRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tenantKey = $v.tenantKey;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateTenantRequest other) {
    _$v = other as _$CreateTenantRequest;
  }

  @override
  void update(void Function(CreateTenantRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateTenantRequest build() => _build();

  _$CreateTenantRequest _build() {
    final _$result =
        _$v ??
        _$CreateTenantRequest._(
          tenantKey: BuiltValueNullFieldError.checkNotNull(
            tenantKey,
            r'CreateTenantRequest',
            'tenantKey',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'CreateTenantRequest',
            'name',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
