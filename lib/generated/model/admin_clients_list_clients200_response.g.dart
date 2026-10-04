// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_clients_list_clients200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminClientsListClients200Response
    extends AdminClientsListClients200Response {
  @override
  final BuiltList<OAuthClient> items;
  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int total;

  factory _$AdminClientsListClients200Response([
    void Function(AdminClientsListClients200ResponseBuilder)? updates,
  ]) => (AdminClientsListClients200ResponseBuilder()..update(updates))._build();

  _$AdminClientsListClients200Response._({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.total,
  }) : super._();
  @override
  AdminClientsListClients200Response rebuild(
    void Function(AdminClientsListClients200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminClientsListClients200ResponseBuilder toBuilder() =>
      AdminClientsListClients200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminClientsListClients200Response &&
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
    return (newBuiltValueToStringHelper(r'AdminClientsListClients200Response')
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('total', total))
        .toString();
  }
}

class AdminClientsListClients200ResponseBuilder
    implements
        Builder<
          AdminClientsListClients200Response,
          AdminClientsListClients200ResponseBuilder
        > {
  _$AdminClientsListClients200Response? _$v;

  ListBuilder<OAuthClient>? _items;
  ListBuilder<OAuthClient> get items =>
      _$this._items ??= ListBuilder<OAuthClient>();
  set items(ListBuilder<OAuthClient>? items) => _$this._items = items;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  AdminClientsListClients200ResponseBuilder() {
    AdminClientsListClients200Response._defaults(this);
  }

  AdminClientsListClients200ResponseBuilder get _$this {
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
  void replace(AdminClientsListClients200Response other) {
    _$v = other as _$AdminClientsListClients200Response;
  }

  @override
  void update(
    void Function(AdminClientsListClients200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminClientsListClients200Response build() => _build();

  _$AdminClientsListClients200Response _build() {
    _$AdminClientsListClients200Response _$result;
    try {
      _$result =
          _$v ??
          _$AdminClientsListClients200Response._(
            items: items.build(),
            page: BuiltValueNullFieldError.checkNotNull(
              page,
              r'AdminClientsListClients200Response',
              'page',
            ),
            pageSize: BuiltValueNullFieldError.checkNotNull(
              pageSize,
              r'AdminClientsListClients200Response',
              'pageSize',
            ),
            total: BuiltValueNullFieldError.checkNotNull(
              total,
              r'AdminClientsListClients200Response',
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
          r'AdminClientsListClients200Response',
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
