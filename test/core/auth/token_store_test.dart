import 'package:flutter_test/flutter_test.dart';

import '../../fakes/in_memory_token_store.dart';

void main() {
  late InMemoryTokenStore store;

  setUp(() => store = InMemoryTokenStore());

  test('save 后两键读回原值', () async {
    await store.save(accessToken: 'at-1', refreshToken: 'rt-1');
    expect(await store.readAccessToken(), 'at-1');
    expect(await store.readRefreshToken(), 'rt-1');
  });

  test('save 覆盖写生效', () async {
    await store.save(accessToken: 'at-1', refreshToken: 'rt-1');
    await store.save(accessToken: 'at-2', refreshToken: 'rt-2');
    expect(await store.readAccessToken(), 'at-2');
  });

  test('clear 后两读全 null', () async {
    await store.save(accessToken: 'at-1', refreshToken: 'rt-1');
    await store.clear();
    expect(await store.readAccessToken(), isNull);
    expect(await store.readRefreshToken(), isNull);
  });
}
