import 'in_memory_token_store.dart';

/// 测试专用：clear() 必抛 StateError 的存储变体（终审 I-1 回归）——
/// 故障注入面：存储写侧故障不得阻断 Authed→Anonymous 迁移（清必达语义）。
class ThrowingClearTokenStore extends InMemoryTokenStore {
  @override
  Future<void> clear() async {
    throw StateError('clear failed (test)');
  }
}
