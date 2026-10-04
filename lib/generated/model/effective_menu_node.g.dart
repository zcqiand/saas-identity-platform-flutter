// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'effective_menu_node.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EffectiveMenuNode extends EffectiveMenuNode {
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
  final BuiltList<EffectiveMenuNode> children;

  factory _$EffectiveMenuNode([
    void Function(EffectiveMenuNodeBuilder)? updates,
  ]) => (EffectiveMenuNodeBuilder()..update(updates))._build();

  _$EffectiveMenuNode._({
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
    required this.children,
  }) : super._();
  @override
  EffectiveMenuNode rebuild(void Function(EffectiveMenuNodeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EffectiveMenuNodeBuilder toBuilder() =>
      EffectiveMenuNodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EffectiveMenuNode &&
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
        children == other.children;
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
    _$hash = $jc(_$hash, children.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EffectiveMenuNode')
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
          ..add('children', children))
        .toString();
  }
}

class EffectiveMenuNodeBuilder
    implements Builder<EffectiveMenuNode, EffectiveMenuNodeBuilder> {
  _$EffectiveMenuNode? _$v;

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

  ListBuilder<EffectiveMenuNode>? _children;
  ListBuilder<EffectiveMenuNode> get children =>
      _$this._children ??= ListBuilder<EffectiveMenuNode>();
  set children(ListBuilder<EffectiveMenuNode>? children) =>
      _$this._children = children;

  EffectiveMenuNodeBuilder() {
    EffectiveMenuNode._defaults(this);
  }

  EffectiveMenuNodeBuilder get _$this {
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
      _children = $v.children.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EffectiveMenuNode other) {
    _$v = other as _$EffectiveMenuNode;
  }

  @override
  void update(void Function(EffectiveMenuNodeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EffectiveMenuNode build() => _build();

  _$EffectiveMenuNode _build() {
    _$EffectiveMenuNode _$result;
    try {
      _$result =
          _$v ??
          _$EffectiveMenuNode._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'EffectiveMenuNode',
              'id',
            ),
            clientId: BuiltValueNullFieldError.checkNotNull(
              clientId,
              r'EffectiveMenuNode',
              'clientId',
            ),
            parentId: BuiltValueNullFieldError.checkNotNull(
              parentId,
              r'EffectiveMenuNode',
              'parentId',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'EffectiveMenuNode',
              'title',
            ),
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'EffectiveMenuNode',
              'type',
            ),
            path: path,
            component: component,
            perms: perms,
            icon: icon,
            sortOrder: BuiltValueNullFieldError.checkNotNull(
              sortOrder,
              r'EffectiveMenuNode',
              'sortOrder',
            ),
            children: children.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'children';
        children.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EffectiveMenuNode',
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
