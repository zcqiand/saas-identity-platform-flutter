// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_menu.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SysMenu extends SysMenu {
  @override
  final String id;
  @override
  final String clientId;
  @override
  final String parentId;
  @override
  final String title;
  @override
  final SysMenuType type;
  @override
  final String? path;
  @override
  final String? component;
  @override
  final String? perms;
  @override
  final String? icon;
  @override
  final int sortOrder;
  @override
  final int status;
  @override
  final DateTime createdAt;

  factory _$SysMenu([void Function(SysMenuBuilder)? updates]) =>
      (SysMenuBuilder()..update(updates))._build();

  _$SysMenu._({
    required this.id,
    required this.clientId,
    required this.parentId,
    required this.title,
    required this.type,
    this.path,
    this.component,
    this.perms,
    this.icon,
    required this.sortOrder,
    required this.status,
    required this.createdAt,
  }) : super._();
  @override
  SysMenu rebuild(void Function(SysMenuBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SysMenuBuilder toBuilder() => SysMenuBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SysMenu &&
        id == other.id &&
        clientId == other.clientId &&
        parentId == other.parentId &&
        title == other.title &&
        type == other.type &&
        path == other.path &&
        component == other.component &&
        perms == other.perms &&
        icon == other.icon &&
        sortOrder == other.sortOrder &&
        status == other.status &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, parentId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, component.hashCode);
    _$hash = $jc(_$hash, perms.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SysMenu')
          ..add('id', id)
          ..add('clientId', clientId)
          ..add('parentId', parentId)
          ..add('title', title)
          ..add('type', type)
          ..add('path', path)
          ..add('component', component)
          ..add('perms', perms)
          ..add('icon', icon)
          ..add('sortOrder', sortOrder)
          ..add('status', status)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class SysMenuBuilder implements Builder<SysMenu, SysMenuBuilder> {
  _$SysMenu? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _parentId;
  String? get parentId => _$this._parentId;
  set parentId(String? parentId) => _$this._parentId = parentId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  SysMenuType? _type;
  SysMenuType? get type => _$this._type;
  set type(SysMenuType? type) => _$this._type = type;

  String? _path;
  String? get path => _$this._path;
  set path(String? path) => _$this._path = path;

  String? _component;
  String? get component => _$this._component;
  set component(String? component) => _$this._component = component;

  String? _perms;
  String? get perms => _$this._perms;
  set perms(String? perms) => _$this._perms = perms;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  SysMenuBuilder() {
    SysMenu._defaults(this);
  }

  SysMenuBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _clientId = $v.clientId;
      _parentId = $v.parentId;
      _title = $v.title;
      _type = $v.type;
      _path = $v.path;
      _component = $v.component;
      _perms = $v.perms;
      _icon = $v.icon;
      _sortOrder = $v.sortOrder;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SysMenu other) {
    _$v = other as _$SysMenu;
  }

  @override
  void update(void Function(SysMenuBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SysMenu build() => _build();

  _$SysMenu _build() {
    final _$result =
        _$v ??
        _$SysMenu._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'SysMenu', 'id'),
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'SysMenu',
            'clientId',
          ),
          parentId: BuiltValueNullFieldError.checkNotNull(
            parentId,
            r'SysMenu',
            'parentId',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'SysMenu',
            'title',
          ),
          type: BuiltValueNullFieldError.checkNotNull(type, r'SysMenu', 'type'),
          path: path,
          component: component,
          perms: perms,
          icon: icon,
          sortOrder: BuiltValueNullFieldError.checkNotNull(
            sortOrder,
            r'SysMenu',
            'sortOrder',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'SysMenu',
            'status',
          ),
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'SysMenu',
            'createdAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
