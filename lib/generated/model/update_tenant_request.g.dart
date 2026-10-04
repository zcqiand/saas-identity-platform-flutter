// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_tenant_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateTenantRequest extends UpdateTenantRequest {
  @override
  final String? name;
  @override
  final TenantStatus? status;

  factory _$UpdateTenantRequest([
    void Function(UpdateTenantRequestBuilder)? updates,
  ]) => (UpdateTenantRequestBuilder()..update(updates))._build();

  _$UpdateTenantRequest._({this.name, this.status}) : super._();
  @override
  UpdateTenantRequest rebuild(
    void Function(UpdateTenantRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateTenantRequestBuilder toBuilder() =>
      UpdateTenantRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateTenantRequest &&
        name == other.name &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateTenantRequest')
          ..add('name', name)
          ..add('status', status))
        .toString();
  }
}

class UpdateTenantRequestBuilder
    implements Builder<UpdateTenantRequest, UpdateTenantRequestBuilder> {
  _$UpdateTenantRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TenantStatus? _status;
  TenantStatus? get status => _$this._status;
  set status(TenantStatus? status) => _$this._status = status;

  UpdateTenantRequestBuilder() {
    UpdateTenantRequest._defaults(this);
  }

  UpdateTenantRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateTenantRequest other) {
    _$v = other as _$UpdateTenantRequest;
  }

  @override
  void update(void Function(UpdateTenantRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateTenantRequest build() => _build();

  _$UpdateTenantRequest _build() {
    final _$result = _$v ?? _$UpdateTenantRequest._(name: name, status: status);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
