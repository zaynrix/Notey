import 'di.dart';
import 'package:dio/dio.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/utils/appConfig.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] =
        "Bearer ${sl<SharedLocal>().getUser().token}";
    options.headers["lang"] = "${sl<SharedLocal>().getLanguage}";
    options.headers["Content-Type"] = "application/json";
    options.headers["X-Requested-With"] = "XMLHttpRequest";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    AppConfig().showException(err);

    super.onError(err, handler);
  }
}
