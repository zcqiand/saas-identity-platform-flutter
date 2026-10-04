// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_clients_set_client_status_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminClientsSetClientStatusRequest
    extends AdminClientsSetClientStatusRequest {
  @override
  final int status;

  factory _$AdminClientsSetClientStatusRequest([
    void Function(AdminClientsSetClientStatusRequestBuilder)? updates,
  ]) => (AdminClientsSetClientStatusRequestBuilder()..update(updates))._build();

  _$AdminClientsSetClientStatusRequest._({required this.status}) : super._();
  @override
  AdminClientsSetClientStatusRequest rebuild(
    void Function(AdminClientsSetClientStatusRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminClientsSetClientStatusRequestBuilder toBuilder() =>
      AdminClientsSetClientStatusRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminClientsSetClientStatusRequest &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AdminClientsSetClientStatusRequest',
    )..add('status', status)).toString();
  }
}

class AdminClientsSetClientStatusRequestBuilder
    implements
        Builder<
          AdminClientsSetClientStatusRequest,
          AdminClientsSetClientStatusRequestBuilder
        > {
  _$AdminClientsSetClientStatusRequest? _$v;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  AdminClientsSetClientStatusRequestBuilder() {
    AdminClientsSetClientStatusRequest._defaults(this);
  }

  AdminClientsSetClientStatusRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminClientsSetClientStatusRequest other) {
    _$v = other as _$AdminClientsSetClientStatusRequest;
  }

  @override
  void update(
    void Function(AdminClientsSetClientStatusRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminClientsSetClientStatusRequest build() => _build();

  _$AdminClientsSetClientStatusRequest _build() {
    final _$result =
        _$v ??
        _$AdminClientsSetClientStatusRequest._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'AdminClientsSetClientStatusRequest',
            'status',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
