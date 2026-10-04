// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reorder_sys_menu_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReorderSysMenuRequest extends ReorderSysMenuRequest {
  @override
  final BuiltList<String> orderedMenuIds;

  factory _$ReorderSysMenuRequest([
    void Function(ReorderSysMenuRequestBuilder)? updates,
  ]) => (ReorderSysMenuRequestBuilder()..update(updates))._build();

  _$ReorderSysMenuRequest._({required this.orderedMenuIds}) : super._();
  @override
  ReorderSysMenuRequest rebuild(
    void Function(ReorderSysMenuRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReorderSysMenuRequestBuilder toBuilder() =>
      ReorderSysMenuRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReorderSysMenuRequest &&
        orderedMenuIds == other.orderedMenuIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderedMenuIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ReorderSysMenuRequest',
    )..add('orderedMenuIds', orderedMenuIds)).toString();
  }
}

class ReorderSysMenuRequestBuilder
    implements Builder<ReorderSysMenuRequest, ReorderSysMenuRequestBuilder> {
  _$ReorderSysMenuRequest? _$v;

  ListBuilder<String>? _orderedMenuIds;
  ListBuilder<String> get orderedMenuIds =>
      _$this._orderedMenuIds ??= ListBuilder<String>();
  set orderedMenuIds(ListBuilder<String>? orderedMenuIds) =>
      _$this._orderedMenuIds = orderedMenuIds;

  ReorderSysMenuRequestBuilder() {
    ReorderSysMenuRequest._defaults(this);
  }

  ReorderSysMenuRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderedMenuIds = $v.orderedMenuIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReorderSysMenuRequest other) {
    _$v = other as _$ReorderSysMenuRequest;
  }

  @override
  void update(void Function(ReorderSysMenuRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReorderSysMenuRequest build() => _build();

  _$ReorderSysMenuRequest _build() {
    _$ReorderSysMenuRequest _$result;
    try {
      _$result =
          _$v ??
          _$ReorderSysMenuRequest._(orderedMenuIds: orderedMenuIds.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'orderedMenuIds';
        orderedMenuIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ReorderSysMenuRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
