// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_applications_list_tenant_applications200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TenantApplicationsListTenantApplications200Response
    extends TenantApplicationsListTenantApplications200Response {
  @override
  final BuiltList<TenantApplication> items;
  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int total;

  factory _$TenantApplicationsListTenantApplications200Response([
    void Function(TenantApplicationsListTenantApplications200ResponseBuilder)?
    updates,
  ]) =>
      (TenantApplicationsListTenantApplications200ResponseBuilder()
            ..update(updates))
          ._build();

  _$TenantApplicationsListTenantApplications200Response._({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.total,
  }) : super._();
  @override
  TenantApplicationsListTenantApplications200Response rebuild(
    void Function(TenantApplicationsListTenantApplications200ResponseBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TenantApplicationsListTenantApplications200ResponseBuilder toBuilder() =>
      TenantApplicationsListTenantApplications200ResponseBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TenantApplicationsListTenantApplications200Response &&
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
    return (newBuiltValueToStringHelper(
            r'TenantApplicationsListTenantApplications200Response',
          )
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('total', total))
        .toString();
  }
}

class TenantApplicationsListTenantApplications200ResponseBuilder
    implements
        Builder<
          TenantApplicationsListTenantApplications200Response,
          TenantApplicationsListTenantApplications200ResponseBuilder
        > {
  _$TenantApplicationsListTenantApplications200Response? _$v;

  ListBuilder<TenantApplication>? _items;
  ListBuilder<TenantApplication> get items =>
      _$this._items ??= ListBuilder<TenantApplication>();
  set items(ListBuilder<TenantApplication>? items) => _$this._items = items;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  TenantApplicationsListTenantApplications200ResponseBuilder() {
    TenantApplicationsListTenantApplications200Response._defaults(this);
  }

  TenantApplicationsListTenantApplications200ResponseBuilder get _$this {
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
  void replace(TenantApplicationsListTenantApplications200Response other) {
    _$v = other as _$TenantApplicationsListTenantApplications200Response;
  }

  @override
  void update(
    void Function(TenantApplicationsListTenantApplications200ResponseBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TenantApplicationsListTenantApplications200Response build() => _build();

  _$TenantApplicationsListTenantApplications200Response _build() {
    _$TenantApplicationsListTenantApplications200Response _$result;
    try {
      _$result =
          _$v ??
          _$TenantApplicationsListTenantApplications200Response._(
            items: items.build(),
            page: BuiltValueNullFieldError.checkNotNull(
              page,
              r'TenantApplicationsListTenantApplications200Response',
              'page',
            ),
            pageSize: BuiltValueNullFieldError.checkNotNull(
              pageSize,
              r'TenantApplicationsListTenantApplications200Response',
              'pageSize',
            ),
            total: BuiltValueNullFieldError.checkNotNull(
              total,
              r'TenantApplicationsListTenantApplications200Response',
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
          r'TenantApplicationsListTenantApplications200Response',
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
