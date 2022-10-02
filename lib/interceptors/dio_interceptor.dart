import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:notey/features/Registrations/auth_provider.dart';
import 'package:notey/utils/appConfig.dart';

import 'di.dart';

class DioInterceptor extends Interceptor with ChangeNotifier {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] =
        "Bearer ${sl<SharedLocal>().getUser().token}";
    print("This is token Bearer ${sl<SharedLocal>().getUser().token}");
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
    // sl<AuthProvider>().changeLoaderInterceptor();
    AppConfig().showException(err);
    print("This is error:  ${sl<AuthProvider>().loading }");

    print("This is error after change :  ${sl<AuthProvider>().loading }");
    notifyListeners();
    super.onError(err, handler);
  }
}
