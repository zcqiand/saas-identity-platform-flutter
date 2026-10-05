// @entry M01.F04.I03
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_controller.dart';
import 'auth_state.dart';

/// 密码登录页（M01.F04.I03）。submitting 禁用按钮；failed 展示文案。
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final submitting = authState is AuthSubmitting;

    return Scaffold(
      appBar: AppBar(title: const Text('登录 — SaaS 身份平台 Flutter 端')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (authState is AuthFailed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      authState.message,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                TextField(
                  controller: _username,
                  decoration: const InputDecoration(
                    labelText: '用户名',
                    border: OutlineInputBorder(),
                  ),
                  enabled: !submitting,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: '密码',
                    border: OutlineInputBorder(),
                  ),
                  enabled: !submitting,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: submitting
                      ? null
                      : () => ref
                            .read(authControllerProvider.notifier)
                            .login(_username.text.trim(), _password.text),
                  child: Text(submitting ? '登录中…' : '登录'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
