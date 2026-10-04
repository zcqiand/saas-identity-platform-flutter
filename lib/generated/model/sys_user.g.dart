// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SysUser extends SysUser {
  @override
  final String id;
  @override
  final String username;
  @override
  final String? email;
  @override
  final String? mobile;
  @override
  final SysUserStatus status;
  @override
  final int? failedAttempts;
  @override
  final DateTime? lockedUntil;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$SysUser([void Function(SysUserBuilder)? updates]) =>
      (SysUserBuilder()..update(updates))._build();

  _$SysUser._({
    required this.id,
    required this.username,
    this.email,
    this.mobile,
    required this.status,
    this.failedAttempts,
    this.lockedUntil,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();
  @override
  SysUser rebuild(void Function(SysUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SysUserBuilder toBuilder() => SysUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SysUser &&
        id == other.id &&
        username == other.username &&
        email == other.email &&
        mobile == other.mobile &&
        status == other.status &&
        failedAttempts == other.failedAttempts &&
        lockedUntil == other.lockedUntil &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, mobile.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, failedAttempts.hashCode);
    _$hash = $jc(_$hash, lockedUntil.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SysUser')
          ..add('id', id)
          ..add('username', username)
          ..add('email', email)
          ..add('mobile', mobile)
          ..add('status', status)
          ..add('failedAttempts', failedAttempts)
          ..add('lockedUntil', lockedUntil)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class SysUserBuilder implements Builder<SysUser, SysUserBuilder> {
  _$SysUser? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _mobile;
  String? get mobile => _$this._mobile;
  set mobile(String? mobile) => _$this._mobile = mobile;

  SysUserStatus? _status;
  SysUserStatus? get status => _$this._status;
  set status(SysUserStatus? status) => _$this._status = status;

  int? _failedAttempts;
  int? get failedAttempts => _$this._failedAttempts;
  set failedAttempts(int? failedAttempts) =>
      _$this._failedAttempts = failedAttempts;

  DateTime? _lockedUntil;
  DateTime? get lockedUntil => _$this._lockedUntil;
  set lockedUntil(DateTime? lockedUntil) => _$this._lockedUntil = lockedUntil;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  SysUserBuilder() {
    SysUser._defaults(this);
  }

  SysUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _username = $v.username;
      _email = $v.email;
      _mobile = $v.mobile;
      _status = $v.status;
      _failedAttempts = $v.failedAttempts;
      _lockedUntil = $v.lockedUntil;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SysUser other) {
    _$v = other as _$SysUser;
  }

  @override
  void update(void Function(SysUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SysUser build() => _build();

  _$SysUser _build() {
    final _$result =
        _$v ??
        _$SysUser._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'SysUser', 'id'),
          username: BuiltValueNullFieldError.checkNotNull(
            username,
            r'SysUser',
            'username',
          ),
          email: email,
          mobile: mobile,
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'SysUser',
            'status',
          ),
          failedAttempts: failedAttempts,
          lockedUntil: lockedUntil,
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'SysUser',
            'createdAt',
          ),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
            updatedAt,
            r'SysUser',
            'updatedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
