import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

/// M00.F01 租户切片 fixtures（G-11 契约六字段口径，禁超面）。
/// 日期 ISO 8601 字符串（serializers 解码 DateTime，lab receipt_fixtures 同款）。
const _now = '2026-10-06T08:00:00Z';

Map<String, dynamic> tenantJson({
  String id = 't-1',
  Map<String, Object?> overrides = const {},
}) {
  final base = <String, dynamic>{
    'id': id,
    'tenantKey': 'tenant-$id',
    'name': '示例租户',
    'status': 'active',
    'createdAt': _now,
    'updatedAt': _now,
  };
  return <String, dynamic>{...base, ...overrides};
}

Map<String, dynamic> tenantListJson(List<Map<String, dynamic>> items) =>
    <String, dynamic>{
      'items': items,
      'page': 1,
      'pageSize': 50,
      'total': items.length,
    };

(Dio, DioAdapter) tenantRig() {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5101'));
  final adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
  return (dio, adapter);
}
