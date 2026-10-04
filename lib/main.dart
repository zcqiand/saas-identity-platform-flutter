import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/app_config.dart';

void main() {
  AppConfig.validate(); // fail-fast：配置缺失不进 UI（suite 硬规则 §1）
  runApp(const ProviderScope(child: SaasFlutterApp()));
}

class SaasFlutterApp extends StatelessWidget {
  const SaasFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaaS 身份平台',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('SaaS 身份平台 Flutter 端')),
        body: const Center(child: Text('Phase 0 骨架：功能随 Phase 1+ 落地')),
      ),
    );
  }
}
