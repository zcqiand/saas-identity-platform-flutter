// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_auth_authorize200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OAuthAuthorize200Response extends OAuthAuthorize200Response {
  @override
  final String code;
  @override
  final String state;

  factory _$OAuthAuthorize200Response([
    void Function(OAuthAuthorize200ResponseBuilder)? updates,
  ]) => (OAuthAuthorize200ResponseBuilder()..update(updates))._build();

  _$OAuthAuthorize200Response._({required this.code, required this.state})
    : super._();
  @override
  OAuthAuthorize200Response rebuild(
    void Function(OAuthAuthorize200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OAuthAuthorize200ResponseBuilder toBuilder() =>
      OAuthAuthorize200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OAuthAuthorize200Response &&
        code == other.code &&
        state == other.state;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OAuthAuthorize200Response')
          ..add('code', code)
          ..add('state', state))
        .toString();
  }
}

class OAuthAuthorize200ResponseBuilder
    implements
        Builder<OAuthAuthorize200Response, OAuthAuthorize200ResponseBuilder> {
  _$OAuthAuthorize200Response? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  OAuthAuthorize200ResponseBuilder() {
    OAuthAuthorize200Response._defaults(this);
  }

  OAuthAuthorize200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _state = $v.state;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OAuthAuthorize200Response other) {
    _$v = other as _$OAuthAuthorize200Response;
  }

  @override
  void update(void Function(OAuthAuthorize200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OAuthAuthorize200Response build() => _build();

  _$OAuthAuthorize200Response _build() {
    final _$result =
        _$v ??
        _$OAuthAuthorize200Response._(
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'OAuthAuthorize200Response',
            'code',
          ),
          state: BuiltValueNullFieldError.checkNotNull(
            state,
            r'OAuthAuthorize200Response',
            'state',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
