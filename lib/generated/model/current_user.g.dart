// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CurrentUser extends CurrentUser {
  @override
  final String id;
  @override
  final String? email;
  @override
  final BuiltList<TenantMembership> memberships;
  @override
  final String? currentTenantId;

  factory _$CurrentUser([void Function(CurrentUserBuilder)? updates]) =>
      (CurrentUserBuilder()..update(updates))._build();

  _$CurrentUser._({
    required this.id,
    this.email,
    required this.memberships,
    this.currentTenantId,
  }) : super._();
  @override
  CurrentUser rebuild(void Function(CurrentUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrentUserBuilder toBuilder() => CurrentUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrentUser &&
        id == other.id &&
        email == other.email &&
        memberships == other.memberships &&
        currentTenantId == other.currentTenantId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, memberships.hashCode);
    _$hash = $jc(_$hash, currentTenantId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CurrentUser')
          ..add('id', id)
          ..add('email', email)
          ..add('memberships', memberships)
          ..add('currentTenantId', currentTenantId))
        .toString();
  }
}

class CurrentUserBuilder implements Builder<CurrentUser, CurrentUserBuilder> {
  _$CurrentUser? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  ListBuilder<TenantMembership>? _memberships;
  ListBuilder<TenantMembership> get memberships =>
      _$this._memberships ??= ListBuilder<TenantMembership>();
  set memberships(ListBuilder<TenantMembership>? memberships) =>
      _$this._memberships = memberships;

  String? _currentTenantId;
  String? get currentTenantId => _$this._currentTenantId;
  set currentTenantId(String? currentTenantId) =>
      _$this._currentTenantId = currentTenantId;

  CurrentUserBuilder() {
    CurrentUser._defaults(this);
  }

  CurrentUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _email = $v.email;
      _memberships = $v.memberships.toBuilder();
      _currentTenantId = $v.currentTenantId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CurrentUser other) {
    _$v = other as _$CurrentUser;
  }

  @override
  void update(void Function(CurrentUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CurrentUser build() => _build();

  _$CurrentUser _build() {
    _$CurrentUser _$result;
    try {
      _$result =
          _$v ??
          _$CurrentUser._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'CurrentUser', 'id'),
            email: email,
            memberships: memberships.build(),
            currentTenantId: currentTenantId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'memberships';
        memberships.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CurrentUser',
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
