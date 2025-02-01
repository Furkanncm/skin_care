import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter_core/flutter_core.dart';

class DioFirebasePerformanceInterceptor extends InterceptorsWrapper {
  DioFirebasePerformanceInterceptor();

  final _map = <int, HttpMetric>{};

  @override
  Future<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final url = options.baseUrl + options.path;
      final metric = FirebasePerformance.instance.newHttpMetric(
        url,
        options.method.asHttpMethod,
      );

      final requestKey = options.extra.hashCode;
      _map[requestKey] = metric;

      await metric.start();
    } catch (_) {}
    return super.onRequest(options, handler);
  }

  @override
  Future<dynamic> onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
    try {
      final requestKey = response.requestOptions.extra.hashCode;
      final metric = _map[requestKey];
      metric?.setResponse(response);
      await metric?.stop();
      _map.remove(requestKey);
    } catch (_) {}
    return super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      final requestKey = err.requestOptions.extra.hashCode;
      final metric = _map[requestKey];
      metric?.setResponse(err.response);
      await metric?.stop();
      _map.remove(requestKey);
    } catch (_) {}
    return super.onError(err, handler);
  }
}

extension _ResponseHttpMetric on HttpMetric {
  void setResponse(Response<dynamic>? value) {
    if (value == null) {
      return;
    }

    final contentType = value.headers.value.call(Headers.contentTypeHeader);
    if (contentType != null) {
      responseContentType = contentType;
    }
    if (value.statusCode != null) {
      httpResponseCode = value.statusCode;
    }
  }
}

extension _StringHttpMethod on String {
  HttpMethod get asHttpMethod => switch (toUpperCase()) {
        'POST' => HttpMethod.Post,
        'GET' => HttpMethod.Get,
        'DELETE' => HttpMethod.Delete,
        'PUT' => HttpMethod.Put,
        'PATCH' => HttpMethod.Patch,
        'OPTIONS' => HttpMethod.Options,
        'HEAD' => HttpMethod.Head,
        'TRACE' => HttpMethod.Trace,
        'CONNECT' => HttpMethod.Connect,
        _ => throw UnimplementedError('Method $this is not supported'),
      };
}
