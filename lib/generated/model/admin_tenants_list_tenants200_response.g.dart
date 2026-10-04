// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_tenants_list_tenants200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminTenantsListTenants200Response
    extends AdminTenantsListTenants200Response {
  @override
  final BuiltList<Tenant> items;
  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int total;

  factory _$AdminTenantsListTenants200Response([
    void Function(AdminTenantsListTenants200ResponseBuilder)? updates,
  ]) => (AdminTenantsListTenants200ResponseBuilder()..update(updates))._build();

  _$AdminTenantsListTenants200Response._({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.total,
  }) : super._();
  @override
  AdminTenantsListTenants200Response rebuild(
    void Function(AdminTenantsListTenants200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminTenantsListTenants200ResponseBuilder toBuilder() =>
      AdminTenantsListTenants200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminTenantsListTenants200Response &&
        items == other.items &&
        page == other.page &&
        pageSize == other.pageSize &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminTenantsListTenants200Response')
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('total', total))
        .toString();
  }
}

class AdminTenantsListTenants200ResponseBuilder
    implements
        Builder<
          AdminTenantsListTenants200Response,
          AdminTenantsListTenants200ResponseBuilder
        > {
  _$AdminTenantsListTenants200Response? _$v;

  ListBuilder<Tenant>? _items;
  ListBuilder<Tenant> get items => _$this._items ??= ListBuilder<Tenant>();
  set items(ListBuilder<Tenant>? items) => _$this._items = items;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  AdminTenantsListTenants200ResponseBuilder() {
    AdminTenantsListTenants200Response._defaults(this);
  }

  AdminTenantsListTenants200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _page = $v.page;
      _pageSize = $v.pageSize;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminTenantsListTenants200Response other) {
    _$v = other as _$AdminTenantsListTenants200Response;
  }

  @override
  void update(
    void Function(AdminTenantsListTenants200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminTenantsListTenants200Response build() => _build();

  _$AdminTenantsListTenants200Response _build() {
    _$AdminTenantsListTenants200Response _$result;
    try {
      _$result =
          _$v ??
          _$AdminTenantsListTenants200Response._(
            items: items.build(),
            page: BuiltValueNullFieldError.checkNotNull(
              page,
              r'AdminTenantsListTenants200Response',
              'page',
            ),
            pageSize: BuiltValueNullFieldError.checkNotNull(
              pageSize,
              r'AdminTenantsListTenants200Response',
              'pageSize',
            ),
            total: BuiltValueNullFieldError.checkNotNull(
              total,
              r'AdminTenantsListTenants200Response',
              'total',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminTenantsListTenants200Response',
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
