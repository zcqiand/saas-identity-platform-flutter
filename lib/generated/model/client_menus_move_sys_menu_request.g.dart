// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_menus_move_sys_menu_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClientMenusMoveSysMenuRequest extends ClientMenusMoveSysMenuRequest {
  @override
  final String? parentId;

  factory _$ClientMenusMoveSysMenuRequest([
    void Function(ClientMenusMoveSysMenuRequestBuilder)? updates,
  ]) => (ClientMenusMoveSysMenuRequestBuilder()..update(updates))._build();

  _$ClientMenusMoveSysMenuRequest._({this.parentId}) : super._();
  @override
  ClientMenusMoveSysMenuRequest rebuild(
    void Function(ClientMenusMoveSysMenuRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ClientMenusMoveSysMenuRequestBuilder toBuilder() =>
      ClientMenusMoveSysMenuRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClientMenusMoveSysMenuRequest && parentId == other.parentId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, parentId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ClientMenusMoveSysMenuRequest',
    )..add('parentId', parentId)).toString();
  }
}

class ClientMenusMoveSysMenuRequestBuilder
    implements
        Builder<
          ClientMenusMoveSysMenuRequest,
          ClientMenusMoveSysMenuRequestBuilder
        > {
  _$ClientMenusMoveSysMenuRequest? _$v;

  String? _parentId;
  String? get parentId => _$this._parentId;
  set parentId(String? parentId) => _$this._parentId = parentId;

  ClientMenusMoveSysMenuRequestBuilder() {
    ClientMenusMoveSysMenuRequest._defaults(this);
  }

  ClientMenusMoveSysMenuRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _parentId = $v.parentId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClientMenusMoveSysMenuRequest other) {
    _$v = other as _$ClientMenusMoveSysMenuRequest;
  }

  @override
  void update(void Function(ClientMenusMoveSysMenuRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClientMenusMoveSysMenuRequest build() => _build();

  _$ClientMenusMoveSysMenuRequest _build() {
    final _$result =
        _$v ?? _$ClientMenusMoveSysMenuRequest._(parentId: parentId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
