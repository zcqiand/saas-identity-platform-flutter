// 生成物冒烟：barrel 可加载 + serializers 可构建（AC-3 生成物可用性）。
// 不挂功能 ID——这是生成管线的机器守卫，不是用户可见功能；
// 生成物本身禁手改（suite 硬规则 §4），有问题改 shared 契约后重跑 gen-shared。
import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

void main() {
  test('生成物 barrel 可加载，serializers / standardSerializers 可构建', () {
    expect(serializers, isNotNull);
    expect(standardSerializers, isNotNull);
  });
}
