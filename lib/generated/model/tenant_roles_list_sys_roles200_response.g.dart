// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_roles_list_sys_roles200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TenantRolesListSysRoles200Response
    extends TenantRolesListSysRoles200Response {
  @override
  final BuiltList<SysRole> items;
  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int total;

  factory _$TenantRolesListSysRoles200Response([
    void Function(TenantRolesListSysRoles200ResponseBuilder)? updates,
  ]) => (TenantRolesListSysRoles200ResponseBuilder()..update(updates))._build();

  _$TenantRolesListSysRoles200Response._({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.total,
  }) : super._();
  @override
  TenantRolesListSysRoles200Response rebuild(
    void Function(TenantRolesListSysRoles200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TenantRolesListSysRoles200ResponseBuilder toBuilder() =>
      TenantRolesListSysRoles200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TenantRolesListSysRoles200Response &&
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
    return (newBuiltValueToStringHelper(r'TenantRolesListSysRoles200Response')
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('total', total))
        .toString();
  }
}

class TenantRolesListSysRoles200ResponseBuilder
    implements
        Builder<
          TenantRolesListSysRoles200Response,
          TenantRolesListSysRoles200ResponseBuilder
        > {
  _$TenantRolesListSysRoles200Response? _$v;

  ListBuilder<SysRole>? _items;
  ListBuilder<SysRole> get items => _$this._items ??= ListBuilder<SysRole>();
  set items(ListBuilder<SysRole>? items) => _$this._items = items;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  TenantRolesListSysRoles200ResponseBuilder() {
    TenantRolesListSysRoles200Response._defaults(this);
  }

  TenantRolesListSysRoles200ResponseBuilder get _$this {
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
  void replace(TenantRolesListSysRoles200Response other) {
    _$v = other as _$TenantRolesListSysRoles200Response;
  }

  @override
  void update(
    void Function(TenantRolesListSysRoles200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TenantRolesListSysRoles200Response build() => _build();

  _$TenantRolesListSysRoles200Response _build() {
    _$TenantRolesListSysRoles200Response _$result;
    try {
      _$result =
          _$v ??
          _$TenantRolesListSysRoles200Response._(
            items: items.build(),
            page: BuiltValueNullFieldError.checkNotNull(
              page,
              r'TenantRolesListSysRoles200Response',
              'page',
            ),
            pageSize: BuiltValueNullFieldError.checkNotNull(
              pageSize,
              r'TenantRolesListSysRoles200Response',
              'pageSize',
            ),
            total: BuiltValueNullFieldError.checkNotNull(
              total,
              r'TenantRolesListSysRoles200Response',
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
          r'TenantRolesListSysRoles200Response',
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
