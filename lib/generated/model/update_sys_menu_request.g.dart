// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_sys_menu_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateSysMenuRequest extends UpdateSysMenuRequest {
  @override
  final String? parentId;
  @override
  final String? title;
  @override
  final SysMenuType? type;
  @override
  final String? path;
  @override
  final String? component;
  @override
  final String? perms;
  @override
  final String? icon;
  @override
  final int? sortOrder;
  @override
  final int? status;

  factory _$UpdateSysMenuRequest([
    void Function(UpdateSysMenuRequestBuilder)? updates,
  ]) => (UpdateSysMenuRequestBuilder()..update(updates))._build();

  _$UpdateSysMenuRequest._({
    this.parentId,
    this.title,
    this.type,
    this.path,
    this.component,
    this.perms,
    this.icon,
    this.sortOrder,
    this.status,
  }) : super._();
  @override
  UpdateSysMenuRequest rebuild(
    void Function(UpdateSysMenuRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateSysMenuRequestBuilder toBuilder() =>
      UpdateSysMenuRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateSysMenuRequest &&
        parentId == other.parentId &&
        title == other.title &&
        type == other.type &&
        path == other.path &&
        component == other.component &&
        perms == other.perms &&
        icon == other.icon &&
        sortOrder == other.sortOrder &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, parentId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, component.hashCode);
    _$hash = $jc(_$hash, perms.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateSysMenuRequest')
          ..add('parentId', parentId)
          ..add('title', title)
          ..add('type', type)
          ..add('path', path)
          ..add('component', component)
          ..add('perms', perms)
          ..add('icon', icon)
          ..add('sortOrder', sortOrder)
          ..add('status', status))
        .toString();
  }
}

class UpdateSysMenuRequestBuilder
    implements Builder<UpdateSysMenuRequest, UpdateSysMenuRequestBuilder> {
  _$UpdateSysMenuRequest? _$v;

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

  UpdateSysMenuRequestBuilder() {
    UpdateSysMenuRequest._defaults(this);
  }

  UpdateSysMenuRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _parentId = $v.parentId;
      _title = $v.title;
      _type = $v.type;
      _path = $v.path;
      _component = $v.component;
      _perms = $v.perms;
      _icon = $v.icon;
      _sortOrder = $v.sortOrder;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateSysMenuRequest other) {
    _$v = other as _$UpdateSysMenuRequest;
  }

  @override
  void update(void Function(UpdateSysMenuRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateSysMenuRequest build() => _build();

  _$UpdateSysMenuRequest _build() {
    final _$result =
        _$v ??
        _$UpdateSysMenuRequest._(
          parentId: parentId,
          title: title,
          type: type,
          path: path,
          component: component,
          perms: perms,
          icon: icon,
          sortOrder: sortOrder,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
