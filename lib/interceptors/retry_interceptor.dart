import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'dio_connectivity_request_retrier.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
    Dio dio;
    Connectivity connectivity;
  RetryOnConnectionChangeInterceptor({required this.dio,required this.connectivity});
    late StreamSubscription streamSubscription;
  void scheduleRequestRetry(RequestOptions requestOptions,ErrorInterceptorHandler handler,DioError error) async {
    final responseCompleter = Completer<Response>();
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();

          try {
            var response = await
              dio.fetch(error.requestOptions
                // requestOptions.path,
                // cancelToken: requestOptions.cancelToken,
                // data: requestOptions.data,
                // onReceiveProgress: requestOptions.onReceiveProgress,
                // onSendProgress: requestOptions.onSendProgress,
                // queryParameters: requestOptions.queryParameters,
                // options: options,
              );
            // print("res");
            handler.resolve(response);
          } on DioError catch (retryError) {
            handler.next(retryError);
          }
          print("This is closure ${requestOptions.path}");
          print("This is closure ${requestOptions.method}");
          // handler.resolve(error);

          // Complete the completer instead of returning
          // responseCompleter.complete(
          //   dio.request(
          //     requestOptions.path,
          //     cancelToken: requestOptions.cancelToken,
          //     data: requestOptions.data,
          //     onReceiveProgress: requestOptions.onReceiveProgress,
          //     onSendProgress: requestOptions.onSendProgress,
          //     queryParameters: requestOptions.queryParameters,
          //     options: options,
          //   ),
          // );

        }


      },
    );

    // return responseCompleter.future;
  }

  // final DioConnectivityRequestRetrier requestRetrier;
  // RetryOnConnectionChangeInterceptor({
  //   @required this.requestRetrier,
  // });

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   AppConfig().showException(err);
  //
  //   super.onError(err, handler);
  // }
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        print("_shouldRetry");
        return scheduleRequestRetry(err.requestOptions,handler,err);
      } catch (e) {
        // Let any new error from the retrier pass through
        return e;
      }
    }
    // Let the error pass through if it's not the error we're looking for
    super.onError(err, handler);
    return err;
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }
}
