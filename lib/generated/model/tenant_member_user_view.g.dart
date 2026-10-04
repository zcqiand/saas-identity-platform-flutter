// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_member_user_view.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TenantMemberUserView extends TenantMemberUserView {
  @override
  final String id;
  @override
  final String tenantId;
  @override
  final String username;
  @override
  final String? email;
  @override
  final TenantMemberStatus status;
  @override
  final BuiltList<String> roleIds;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$TenantMemberUserView([
    void Function(TenantMemberUserViewBuilder)? updates,
  ]) => (TenantMemberUserViewBuilder()..update(updates))._build();

  _$TenantMemberUserView._({
    required this.id,
    required this.tenantId,
    required this.username,
    this.email,
    required this.status,
    required this.roleIds,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();
  @override
  TenantMemberUserView rebuild(
    void Function(TenantMemberUserViewBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TenantMemberUserViewBuilder toBuilder() =>
      TenantMemberUserViewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TenantMemberUserView &&
        id == other.id &&
        tenantId == other.tenantId &&
        username == other.username &&
        email == other.email &&
        status == other.status &&
        roleIds == other.roleIds &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, tenantId.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, roleIds.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TenantMemberUserView')
          ..add('id', id)
          ..add('tenantId', tenantId)
          ..add('username', username)
          ..add('email', email)
          ..add('status', status)
          ..add('roleIds', roleIds)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class TenantMemberUserViewBuilder
    implements Builder<TenantMemberUserView, TenantMemberUserViewBuilder> {
  _$TenantMemberUserView? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _tenantId;
  String? get tenantId => _$this._tenantId;
  set tenantId(String? tenantId) => _$this._tenantId = tenantId;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  TenantMemberStatus? _status;
  TenantMemberStatus? get status => _$this._status;
  set status(TenantMemberStatus? status) => _$this._status = status;

  ListBuilder<String>? _roleIds;
  ListBuilder<String> get roleIds => _$this._roleIds ??= ListBuilder<String>();
  set roleIds(ListBuilder<String>? roleIds) => _$this._roleIds = roleIds;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  TenantMemberUserViewBuilder() {
    TenantMemberUserView._defaults(this);
  }

  TenantMemberUserViewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _tenantId = $v.tenantId;
      _username = $v.username;
      _email = $v.email;
      _status = $v.status;
      _roleIds = $v.roleIds.toBuilder();
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TenantMemberUserView other) {
    _$v = other as _$TenantMemberUserView;
  }

  @override
  void update(void Function(TenantMemberUserViewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TenantMemberUserView build() => _build();

  _$TenantMemberUserView _build() {
    _$TenantMemberUserView _$result;
    try {
      _$result =
          _$v ??
          _$TenantMemberUserView._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'TenantMemberUserView',
              'id',
            ),
            tenantId: BuiltValueNullFieldError.checkNotNull(
              tenantId,
              r'TenantMemberUserView',
              'tenantId',
            ),
            username: BuiltValueNullFieldError.checkNotNull(
              username,
              r'TenantMemberUserView',
              'username',
            ),
            email: email,
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'TenantMemberUserView',
              'status',
            ),
            roleIds: roleIds.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'TenantMemberUserView',
              'createdAt',
            ),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt,
              r'TenantMemberUserView',
              'updatedAt',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'roleIds';
        roleIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TenantMemberUserView',
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
