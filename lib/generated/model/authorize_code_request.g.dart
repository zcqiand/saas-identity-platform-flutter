// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorize_code_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthorizeCodeRequestResponseTypeEnum
_$authorizeCodeRequestResponseTypeEnum_code =
    const AuthorizeCodeRequestResponseTypeEnum._('code');

AuthorizeCodeRequestResponseTypeEnum
_$authorizeCodeRequestResponseTypeEnumValueOf(String name) {
  switch (name) {
    case 'code':
      return _$authorizeCodeRequestResponseTypeEnum_code;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthorizeCodeRequestResponseTypeEnum>
_$authorizeCodeRequestResponseTypeEnumValues =
    BuiltSet<AuthorizeCodeRequestResponseTypeEnum>(
      const <AuthorizeCodeRequestResponseTypeEnum>[
        _$authorizeCodeRequestResponseTypeEnum_code,
      ],
    );

Serializer<AuthorizeCodeRequestResponseTypeEnum>
_$authorizeCodeRequestResponseTypeEnumSerializer =
    _$AuthorizeCodeRequestResponseTypeEnumSerializer();

class _$AuthorizeCodeRequestResponseTypeEnumSerializer
    implements PrimitiveSerializer<AuthorizeCodeRequestResponseTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'code': 'code',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'code': 'code',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthorizeCodeRequestResponseTypeEnum,
  ];
  @override
  final String wireName = 'AuthorizeCodeRequestResponseTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthorizeCodeRequestResponseTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthorizeCodeRequestResponseTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthorizeCodeRequestResponseTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthorizeCodeRequest extends AuthorizeCodeRequest {
  @override
  final String clientId;
  @override
  final String redirectUri;
  @override
  final AuthorizeCodeRequestResponseTypeEnum responseType;
  @override
  final String? scope;
  @override
  final String state;

  factory _$AuthorizeCodeRequest([
    void Function(AuthorizeCodeRequestBuilder)? updates,
  ]) => (AuthorizeCodeRequestBuilder()..update(updates))._build();

  _$AuthorizeCodeRequest._({
    required this.clientId,
    required this.redirectUri,
    required this.responseType,
    this.scope,
    required this.state,
  }) : super._();
  @override
  AuthorizeCodeRequest rebuild(
    void Function(AuthorizeCodeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthorizeCodeRequestBuilder toBuilder() =>
      AuthorizeCodeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthorizeCodeRequest &&
        clientId == other.clientId &&
        redirectUri == other.redirectUri &&
        responseType == other.responseType &&
        scope == other.scope &&
        state == other.state;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, redirectUri.hashCode);
    _$hash = $jc(_$hash, responseType.hashCode);
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthorizeCodeRequest')
          ..add('clientId', clientId)
          ..add('redirectUri', redirectUri)
          ..add('responseType', responseType)
          ..add('scope', scope)
          ..add('state', state))
        .toString();
  }
}

class AuthorizeCodeRequestBuilder
    implements Builder<AuthorizeCodeRequest, AuthorizeCodeRequestBuilder> {
  _$AuthorizeCodeRequest? _$v;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _redirectUri;
  String? get redirectUri => _$this._redirectUri;
  set redirectUri(String? redirectUri) => _$this._redirectUri = redirectUri;

  AuthorizeCodeRequestResponseTypeEnum? _responseType;
  AuthorizeCodeRequestResponseTypeEnum? get responseType =>
      _$this._responseType;
  set responseType(AuthorizeCodeRequestResponseTypeEnum? responseType) =>
      _$this._responseType = responseType;

  String? _scope;
  String? get scope => _$this._scope;
  set scope(String? scope) => _$this._scope = scope;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  AuthorizeCodeRequestBuilder() {
    AuthorizeCodeRequest._defaults(this);
  }

  AuthorizeCodeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientId = $v.clientId;
      _redirectUri = $v.redirectUri;
      _responseType = $v.responseType;
      _scope = $v.scope;
      _state = $v.state;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthorizeCodeRequest other) {
    _$v = other as _$AuthorizeCodeRequest;
  }

  @override
  void update(void Function(AuthorizeCodeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthorizeCodeRequest build() => _build();

  _$AuthorizeCodeRequest _build() {
    final _$result =
        _$v ??
        _$AuthorizeCodeRequest._(
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'AuthorizeCodeRequest',
            'clientId',
          ),
          redirectUri: BuiltValueNullFieldError.checkNotNull(
            redirectUri,
            r'AuthorizeCodeRequest',
            'redirectUri',
          ),
          responseType: BuiltValueNullFieldError.checkNotNull(
            responseType,
            r'AuthorizeCodeRequest',
            'responseType',
          ),
          scope: scope,
          state: BuiltValueNullFieldError.checkNotNull(
            state,
            r'AuthorizeCodeRequest',
            'state',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
