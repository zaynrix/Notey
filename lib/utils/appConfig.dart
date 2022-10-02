import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/routing/routes.dart';

import '../interceptors/dio_exception.dart';

class AppConfig extends ChangeNotifier {
  Future<Timer> loadData() async {
    // sl<SharedLocal>().removeUser();
    return Timer(const Duration(seconds: 3), onDoneLoading);
  }

// AppConfig(){
//   sl<HomeProvider>().getHome();
//
// }

  var shared = sl<SharedLocal>();

  onDoneLoading() async {
    // sl<NavigationService>().navigateToAndRemove(Routes.login);
        sl<HomeProvider>().getHome();

    if (shared.firstIntro == true) {
      if (shared.getUser().token == null) {
        sl<NavigationService>().navigateToAndRemove(Routes.login);
      } else {
        sl<NavigationService>().navigateToAndRemove(Routes.home);
      }
    } else {
      sl<SharedLocal>().firstIntro = true;
      sl<NavigationService>().navigateToAndRemove(Routes.intro);
    }
  }

  TextTheme getTextContext(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  static showSnakBar(String content) {
    return sl<NavigationService>()
        .snackBarKey
        .currentState
        ?.showSnackBar(SnackBar(content: Text(content.tr())));
  }

  showException(DioError e){

    final errorMessage = DioExceptions.fromDioError(e).toString();
    AppConfig.showSnakBar(
        "${e.response!.data == null ? e.response!.data["message"] : errorMessage}");
  }
}
