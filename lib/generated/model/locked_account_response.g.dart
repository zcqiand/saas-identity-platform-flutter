// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locked_account_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LockedAccountResponse extends LockedAccountResponse {
  @override
  final String code;
  @override
  final String message;
  @override
  final DateTime lockedUntil;
  @override
  final int? remainingAttempts;

  factory _$LockedAccountResponse([
    void Function(LockedAccountResponseBuilder)? updates,
  ]) => (LockedAccountResponseBuilder()..update(updates))._build();

  _$LockedAccountResponse._({
    required this.code,
    required this.message,
    required this.lockedUntil,
    this.remainingAttempts,
  }) : super._();
  @override
  LockedAccountResponse rebuild(
    void Function(LockedAccountResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LockedAccountResponseBuilder toBuilder() =>
      LockedAccountResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LockedAccountResponse &&
        code == other.code &&
        message == other.message &&
        lockedUntil == other.lockedUntil &&
        remainingAttempts == other.remainingAttempts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, lockedUntil.hashCode);
    _$hash = $jc(_$hash, remainingAttempts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LockedAccountResponse')
          ..add('code', code)
          ..add('message', message)
          ..add('lockedUntil', lockedUntil)
          ..add('remainingAttempts', remainingAttempts))
        .toString();
  }
}

class LockedAccountResponseBuilder
    implements Builder<LockedAccountResponse, LockedAccountResponseBuilder> {
  _$LockedAccountResponse? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DateTime? _lockedUntil;
  DateTime? get lockedUntil => _$this._lockedUntil;
  set lockedUntil(DateTime? lockedUntil) => _$this._lockedUntil = lockedUntil;

  int? _remainingAttempts;
  int? get remainingAttempts => _$this._remainingAttempts;
  set remainingAttempts(int? remainingAttempts) =>
      _$this._remainingAttempts = remainingAttempts;

  LockedAccountResponseBuilder() {
    LockedAccountResponse._defaults(this);
  }

  LockedAccountResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _message = $v.message;
      _lockedUntil = $v.lockedUntil;
      _remainingAttempts = $v.remainingAttempts;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LockedAccountResponse other) {
    _$v = other as _$LockedAccountResponse;
  }

  @override
  void update(void Function(LockedAccountResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LockedAccountResponse build() => _build();

  _$LockedAccountResponse _build() {
    final _$result =
        _$v ??
        _$LockedAccountResponse._(
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'LockedAccountResponse',
            'code',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'LockedAccountResponse',
            'message',
          ),
          lockedUntil: BuiltValueNullFieldError.checkNotNull(
            lockedUntil,
            r'LockedAccountResponse',
            'lockedUntil',
          ),
          remainingAttempts: remainingAttempts,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
