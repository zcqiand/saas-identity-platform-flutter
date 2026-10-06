import 'package:flutter_test/flutter_test.dart';

import 'package:saas_identity_platform_flutter/generated/saas_shared_generated.dart';

import 'tenant_fixtures.dart';

void main() {
  test('tenantJson 六字段全集 + status 默认 active 解码', () {
    final t = standardSerializers.deserializeWith(
      Tenant.serializer,
      tenantJson(),
    )!;
    expect(t.id, 't-1');
    expect(t.tenantKey, 'tenant-t-1');
    expect(t.name, '示例租户');
    expect(t.status, TenantStatus.active);
    expect(t.createdAt, isNotNull);
    expect(t.updatedAt, isNotNull);
  });

  test('覆写 suspended → TenantStatus.suspended', () {
    final t = standardSerializers.deserializeWith(
      Tenant.serializer,
      tenantJson(id: 't-2', overrides: {'status': 'suspended'}),
    )!;
    expect(t.status, TenantStatus.suspended);
  });

  test('tenantListJson 经响应模型解码 items/total 正确', () {
    final r = standardSerializers.deserializeWith(
      AdminTenantsListTenants200Response.serializer,
      tenantListJson([tenantJson(id: 't-1'), tenantJson(id: 't-2')]),
    )!;
    expect(r.items.length, 2);
    expect(r.total, 2);
    expect(r.page, 1);
    expect(r.pageSize, 50);
  });
}
