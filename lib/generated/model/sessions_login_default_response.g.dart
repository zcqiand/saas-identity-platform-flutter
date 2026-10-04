// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions_login_default_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SessionsLoginDefaultResponse extends SessionsLoginDefaultResponse {
  @override
  final AnyOf anyOf;

  factory _$SessionsLoginDefaultResponse([
    void Function(SessionsLoginDefaultResponseBuilder)? updates,
  ]) => (SessionsLoginDefaultResponseBuilder()..update(updates))._build();

  _$SessionsLoginDefaultResponse._({required this.anyOf}) : super._();
  @override
  SessionsLoginDefaultResponse rebuild(
    void Function(SessionsLoginDefaultResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SessionsLoginDefaultResponseBuilder toBuilder() =>
      SessionsLoginDefaultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionsLoginDefaultResponse && anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SessionsLoginDefaultResponse',
    )..add('anyOf', anyOf)).toString();
  }
}

class SessionsLoginDefaultResponseBuilder
    implements
        Builder<
          SessionsLoginDefaultResponse,
          SessionsLoginDefaultResponseBuilder
        > {
  _$SessionsLoginDefaultResponse? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  SessionsLoginDefaultResponseBuilder() {
    SessionsLoginDefaultResponse._defaults(this);
  }

  SessionsLoginDefaultResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionsLoginDefaultResponse other) {
    _$v = other as _$SessionsLoginDefaultResponse;
  }

  @override
  void update(void Function(SessionsLoginDefaultResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionsLoginDefaultResponse build() => _build();

  _$SessionsLoginDefaultResponse _build() {
    final _$result =
        _$v ??
        _$SessionsLoginDefaultResponse._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'SessionsLoginDefaultResponse',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
