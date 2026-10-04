// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TokenRequestGrantTypeEnum _$tokenRequestGrantTypeEnum_authorizationCode =
    const TokenRequestGrantTypeEnum._('authorizationCode');
const TokenRequestGrantTypeEnum _$tokenRequestGrantTypeEnum_refreshToken =
    const TokenRequestGrantTypeEnum._('refreshToken');

TokenRequestGrantTypeEnum _$tokenRequestGrantTypeEnumValueOf(String name) {
  switch (name) {
    case 'authorizationCode':
      return _$tokenRequestGrantTypeEnum_authorizationCode;
    case 'refreshToken':
      return _$tokenRequestGrantTypeEnum_refreshToken;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TokenRequestGrantTypeEnum> _$tokenRequestGrantTypeEnumValues =
    BuiltSet<TokenRequestGrantTypeEnum>(const <TokenRequestGrantTypeEnum>[
      _$tokenRequestGrantTypeEnum_authorizationCode,
      _$tokenRequestGrantTypeEnum_refreshToken,
    ]);

Serializer<TokenRequestGrantTypeEnum> _$tokenRequestGrantTypeEnumSerializer =
    _$TokenRequestGrantTypeEnumSerializer();

class _$TokenRequestGrantTypeEnumSerializer
    implements PrimitiveSerializer<TokenRequestGrantTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'authorizationCode': 'authorization_code',
    'refreshToken': 'refresh_token',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'authorization_code': 'authorizationCode',
    'refresh_token': 'refreshToken',
  };

  @override
  final Iterable<Type> types = const <Type>[TokenRequestGrantTypeEnum];
  @override
  final String wireName = 'TokenRequestGrantTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TokenRequestGrantTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TokenRequestGrantTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TokenRequestGrantTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TokenRequest extends TokenRequest {
  @override
  final TokenRequestGrantTypeEnum grantType;
  @override
  final String? code;
  @override
  final String? refreshToken;
  @override
  final String clientId;
  @override
  final String? clientSecret;
  @override
  final String? redirectUri;

  factory _$TokenRequest([void Function(TokenRequestBuilder)? updates]) =>
      (TokenRequestBuilder()..update(updates))._build();

  _$TokenRequest._({
    required this.grantType,
    this.code,
    this.refreshToken,
    required this.clientId,
    this.clientSecret,
    this.redirectUri,
  }) : super._();
  @override
  TokenRequest rebuild(void Function(TokenRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenRequestBuilder toBuilder() => TokenRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenRequest &&
        grantType == other.grantType &&
        code == other.code &&
        refreshToken == other.refreshToken &&
        clientId == other.clientId &&
        clientSecret == other.clientSecret &&
        redirectUri == other.redirectUri;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, grantType.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, clientSecret.hashCode);
    _$hash = $jc(_$hash, redirectUri.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TokenRequest')
          ..add('grantType', grantType)
          ..add('code', code)
          ..add('refreshToken', refreshToken)
          ..add('clientId', clientId)
          ..add('clientSecret', clientSecret)
          ..add('redirectUri', redirectUri))
        .toString();
  }
}

class TokenRequestBuilder
    implements Builder<TokenRequest, TokenRequestBuilder> {
  _$TokenRequest? _$v;

  TokenRequestGrantTypeEnum? _grantType;
  TokenRequestGrantTypeEnum? get grantType => _$this._grantType;
  set grantType(TokenRequestGrantTypeEnum? grantType) =>
      _$this._grantType = grantType;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _clientSecret;
  String? get clientSecret => _$this._clientSecret;
  set clientSecret(String? clientSecret) => _$this._clientSecret = clientSecret;

  String? _redirectUri;
  String? get redirectUri => _$this._redirectUri;
  set redirectUri(String? redirectUri) => _$this._redirectUri = redirectUri;

  TokenRequestBuilder() {
    TokenRequest._defaults(this);
  }

  TokenRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _grantType = $v.grantType;
      _code = $v.code;
      _refreshToken = $v.refreshToken;
      _clientId = $v.clientId;
      _clientSecret = $v.clientSecret;
      _redirectUri = $v.redirectUri;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenRequest other) {
    _$v = other as _$TokenRequest;
  }

  @override
  void update(void Function(TokenRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TokenRequest build() => _build();

  _$TokenRequest _build() {
    final _$result =
        _$v ??
        _$TokenRequest._(
          grantType: BuiltValueNullFieldError.checkNotNull(
            grantType,
            r'TokenRequest',
            'grantType',
          ),
          code: code,
          refreshToken: refreshToken,
          clientId: BuiltValueNullFieldError.checkNotNull(
            clientId,
            r'TokenRequest',
            'clientId',
          ),
          clientSecret: clientSecret,
          redirectUri: redirectUri,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
