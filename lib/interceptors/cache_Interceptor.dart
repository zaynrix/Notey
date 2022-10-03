import 'package:dio/dio.dart';

class CacheInterceptor extends Interceptor {
  CacheInterceptor();

  var _cache = new Map<Uri, Response>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _cache[response.requestOptions.uri] = response;
    super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    print('onError: $err');
    if (err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.other) {
      var cachedResponse = _cache[err.requestOptions.uri];
      cachedResponse ?? cachedResponse;
    }
    super.onError(err, handler);
  }
}
