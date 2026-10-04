// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_member.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TenantMember extends TenantMember {
  @override
  final String id;
  @override
  final String tenantId;
  @override
  final String userId;
  @override
  final String? memberName;
  @override
  final bool isOwner;
  @override
  final TenantMemberStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$TenantMember([void Function(TenantMemberBuilder)? updates]) =>
      (TenantMemberBuilder()..update(updates))._build();

  _$TenantMember._({
    required this.id,
    required this.tenantId,
    required this.userId,
    this.memberName,
    required this.isOwner,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();
  @override
  TenantMember rebuild(void Function(TenantMemberBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TenantMemberBuilder toBuilder() => TenantMemberBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TenantMember &&
        id == other.id &&
        tenantId == other.tenantId &&
        userId == other.userId &&
        memberName == other.memberName &&
        isOwner == other.isOwner &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, tenantId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, memberName.hashCode);
    _$hash = $jc(_$hash, isOwner.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TenantMember')
          ..add('id', id)
          ..add('tenantId', tenantId)
          ..add('userId', userId)
          ..add('memberName', memberName)
          ..add('isOwner', isOwner)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class TenantMemberBuilder
    implements Builder<TenantMember, TenantMemberBuilder> {
  _$TenantMember? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _tenantId;
  String? get tenantId => _$this._tenantId;
  set tenantId(String? tenantId) => _$this._tenantId = tenantId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _memberName;
  String? get memberName => _$this._memberName;
  set memberName(String? memberName) => _$this._memberName = memberName;

  bool? _isOwner;
  bool? get isOwner => _$this._isOwner;
  set isOwner(bool? isOwner) => _$this._isOwner = isOwner;

  TenantMemberStatus? _status;
  TenantMemberStatus? get status => _$this._status;
  set status(TenantMemberStatus? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  TenantMemberBuilder() {
    TenantMember._defaults(this);
  }

  TenantMemberBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _tenantId = $v.tenantId;
      _userId = $v.userId;
      _memberName = $v.memberName;
      _isOwner = $v.isOwner;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TenantMember other) {
    _$v = other as _$TenantMember;
  }

  @override
  void update(void Function(TenantMemberBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TenantMember build() => _build();

  _$TenantMember _build() {
    final _$result =
        _$v ??
        _$TenantMember._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'TenantMember', 'id'),
          tenantId: BuiltValueNullFieldError.checkNotNull(
            tenantId,
            r'TenantMember',
            'tenantId',
          ),
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'TenantMember',
            'userId',
          ),
          memberName: memberName,
          isOwner: BuiltValueNullFieldError.checkNotNull(
            isOwner,
            r'TenantMember',
            'isOwner',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'TenantMember',
            'status',
          ),
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'TenantMember',
            'createdAt',
          ),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
            updatedAt,
            r'TenantMember',
            'updatedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
