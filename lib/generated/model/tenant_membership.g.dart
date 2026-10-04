// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_membership.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TenantMembership extends TenantMembership {
  @override
  final String id;
  @override
  final String userId;
  @override
  final String tenantId;
  @override
  final BuiltList<String> roleIds;
  @override
  final TenantMemberStatus status;
  @override
  final DateTime joinedAt;

  factory _$TenantMembership([
    void Function(TenantMembershipBuilder)? updates,
  ]) => (TenantMembershipBuilder()..update(updates))._build();

  _$TenantMembership._({
    required this.id,
    required this.userId,
    required this.tenantId,
    required this.roleIds,
    required this.status,
    required this.joinedAt,
  }) : super._();
  @override
  TenantMembership rebuild(void Function(TenantMembershipBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TenantMembershipBuilder toBuilder() =>
      TenantMembershipBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TenantMembership &&
        id == other.id &&
        userId == other.userId &&
        tenantId == other.tenantId &&
        roleIds == other.roleIds &&
        status == other.status &&
        joinedAt == other.joinedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, tenantId.hashCode);
    _$hash = $jc(_$hash, roleIds.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, joinedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TenantMembership')
          ..add('id', id)
          ..add('userId', userId)
          ..add('tenantId', tenantId)
          ..add('roleIds', roleIds)
          ..add('status', status)
          ..add('joinedAt', joinedAt))
        .toString();
  }
}

class TenantMembershipBuilder
    implements Builder<TenantMembership, TenantMembershipBuilder> {
  _$TenantMembership? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _tenantId;
  String? get tenantId => _$this._tenantId;
  set tenantId(String? tenantId) => _$this._tenantId = tenantId;

  ListBuilder<String>? _roleIds;
  ListBuilder<String> get roleIds => _$this._roleIds ??= ListBuilder<String>();
  set roleIds(ListBuilder<String>? roleIds) => _$this._roleIds = roleIds;

  TenantMemberStatus? _status;
  TenantMemberStatus? get status => _$this._status;
  set status(TenantMemberStatus? status) => _$this._status = status;

  DateTime? _joinedAt;
  DateTime? get joinedAt => _$this._joinedAt;
  set joinedAt(DateTime? joinedAt) => _$this._joinedAt = joinedAt;

  TenantMembershipBuilder() {
    TenantMembership._defaults(this);
  }

  TenantMembershipBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _tenantId = $v.tenantId;
      _roleIds = $v.roleIds.toBuilder();
      _status = $v.status;
      _joinedAt = $v.joinedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TenantMembership other) {
    _$v = other as _$TenantMembership;
  }

  @override
  void update(void Function(TenantMembershipBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TenantMembership build() => _build();

  _$TenantMembership _build() {
    _$TenantMembership _$result;
    try {
      _$result =
          _$v ??
          _$TenantMembership._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'TenantMembership',
              'id',
            ),
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'TenantMembership',
              'userId',
            ),
            tenantId: BuiltValueNullFieldError.checkNotNull(
              tenantId,
              r'TenantMembership',
              'tenantId',
            ),
            roleIds: roleIds.build(),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'TenantMembership',
              'status',
            ),
            joinedAt: BuiltValueNullFieldError.checkNotNull(
              joinedAt,
              r'TenantMembership',
              'joinedAt',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'roleIds';
        roleIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TenantMembership',
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
