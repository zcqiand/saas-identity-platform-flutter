// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_members_list_tenant_users200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TenantMembersListTenantUsers200Response
    extends TenantMembersListTenantUsers200Response {
  @override
  final BuiltList<TenantMemberUserView> items;
  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int total;

  factory _$TenantMembersListTenantUsers200Response([
    void Function(TenantMembersListTenantUsers200ResponseBuilder)? updates,
  ]) => (TenantMembersListTenantUsers200ResponseBuilder()..update(updates))
      ._build();

  _$TenantMembersListTenantUsers200Response._({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.total,
  }) : super._();
  @override
  TenantMembersListTenantUsers200Response rebuild(
    void Function(TenantMembersListTenantUsers200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TenantMembersListTenantUsers200ResponseBuilder toBuilder() =>
      TenantMembersListTenantUsers200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TenantMembersListTenantUsers200Response &&
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
            r'TenantMembersListTenantUsers200Response',
          )
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('total', total))
        .toString();
  }
}

class TenantMembersListTenantUsers200ResponseBuilder
    implements
        Builder<
          TenantMembersListTenantUsers200Response,
          TenantMembersListTenantUsers200ResponseBuilder
        > {
  _$TenantMembersListTenantUsers200Response? _$v;

  ListBuilder<TenantMemberUserView>? _items;
  ListBuilder<TenantMemberUserView> get items =>
      _$this._items ??= ListBuilder<TenantMemberUserView>();
  set items(ListBuilder<TenantMemberUserView>? items) => _$this._items = items;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  TenantMembersListTenantUsers200ResponseBuilder() {
    TenantMembersListTenantUsers200Response._defaults(this);
  }

  TenantMembersListTenantUsers200ResponseBuilder get _$this {
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
  void replace(TenantMembersListTenantUsers200Response other) {
    _$v = other as _$TenantMembersListTenantUsers200Response;
  }

  @override
  void update(
    void Function(TenantMembersListTenantUsers200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TenantMembersListTenantUsers200Response build() => _build();

  _$TenantMembersListTenantUsers200Response _build() {
    _$TenantMembersListTenantUsers200Response _$result;
    try {
      _$result =
          _$v ??
          _$TenantMembersListTenantUsers200Response._(
            items: items.build(),
            page: BuiltValueNullFieldError.checkNotNull(
              page,
              r'TenantMembersListTenantUsers200Response',
              'page',
            ),
            pageSize: BuiltValueNullFieldError.checkNotNull(
              pageSize,
              r'TenantMembersListTenantUsers200Response',
              'pageSize',
            ),
            total: BuiltValueNullFieldError.checkNotNull(
              total,
              r'TenantMembersListTenantUsers200Response',
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
          r'TenantMembersListTenantUsers200Response',
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
