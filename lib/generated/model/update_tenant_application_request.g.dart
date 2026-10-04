// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_tenant_application_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateTenantApplicationRequest extends UpdateTenantApplicationRequest {
  @override
  final int status;
  @override
  final DateTime? expireTime;

  factory _$UpdateTenantApplicationRequest([
    void Function(UpdateTenantApplicationRequestBuilder)? updates,
  ]) => (UpdateTenantApplicationRequestBuilder()..update(updates))._build();

  _$UpdateTenantApplicationRequest._({required this.status, this.expireTime})
    : super._();
  @override
  UpdateTenantApplicationRequest rebuild(
    void Function(UpdateTenantApplicationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateTenantApplicationRequestBuilder toBuilder() =>
      UpdateTenantApplicationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateTenantApplicationRequest &&
        status == other.status &&
        expireTime == other.expireTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, expireTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateTenantApplicationRequest')
          ..add('status', status)
          ..add('expireTime', expireTime))
        .toString();
  }
}

class UpdateTenantApplicationRequestBuilder
    implements
        Builder<
          UpdateTenantApplicationRequest,
          UpdateTenantApplicationRequestBuilder
        > {
  _$UpdateTenantApplicationRequest? _$v;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  DateTime? _expireTime;
  DateTime? get expireTime => _$this._expireTime;
  set expireTime(DateTime? expireTime) => _$this._expireTime = expireTime;

  UpdateTenantApplicationRequestBuilder() {
    UpdateTenantApplicationRequest._defaults(this);
  }

  UpdateTenantApplicationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _expireTime = $v.expireTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateTenantApplicationRequest other) {
    _$v = other as _$UpdateTenantApplicationRequest;
  }

  @override
  void update(void Function(UpdateTenantApplicationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateTenantApplicationRequest build() => _build();

  _$UpdateTenantApplicationRequest _build() {
    final _$result =
        _$v ??
        _$UpdateTenantApplicationRequest._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'UpdateTenantApplicationRequest',
            'status',
          ),
          expireTime: expireTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
