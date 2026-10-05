import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/auth/auth_controller.dart';
import 'core/auth/auth_state.dart';
import 'core/auth/login_page.dart';
import 'core/config/app_config.dart';

void main() {
  AppConfig.validate(); // fail-fast：配置缺失不进 UI（suite 硬规则 §1）
  runApp(const ProviderScope(child: SaasFlutterApp()));
}

class SaasFlutterApp extends ConsumerWidget {
  const SaasFlutterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    return MaterialApp(
      title: 'SaaS 身份平台',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: switch (authState) {
        AuthRestoring() => const _Splash(),
        AuthAnonymous() ||
        AuthFailed() ||
        AuthSubmitting() => const LoginPage(),
        Authed() => const _Shell(),
      },
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}

/// Phase 1 占位壳：Phase 2 业务页落地前的已登录视图（含登出出口）。
class _Shell extends ConsumerWidget {
  const _Shell();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SaaS 身份平台 Flutter 端'),
        actions: [
          IconButton(
            tooltip: '登出',
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: const Center(child: Text('已登录（Phase 1 占位壳）')),
    );
  }
}
