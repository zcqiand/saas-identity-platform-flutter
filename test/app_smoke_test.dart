import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/core/config/app_config.dart';
import 'package:saas_identity_platform_flutter/main.dart';

void main() {
  group('AppConfig fail-fast', () {
    test('空 base URL 必须 throw（硬规则 §1）', () {
      expect(() => AppConfig.validateBaseUrl(''), throwsStateError);
    });

    test('非空 base URL 通过', () {
      expect(() => AppConfig.validateBaseUrl('http://localhost:5101'), returnsNormally);
    });
  });

  testWidgets('App 壳可构建', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: SaasFlutterApp()));
    expect(find.text('SaaS 身份平台 Flutter 端'), findsOneWidget);
  });
}
