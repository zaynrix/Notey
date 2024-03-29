import 'dart:async';
import 'package:flutter/foundation.dart';

import 'dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:notey/api/endPoints.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/api/remote/auth_api.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:notey/repository/home_repo/task_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notey/repository/user_repo/login_repo.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:notey/features/Registrations/auth_provider.dart';
import 'package:notey/repository/setting_repo/srtting_repo.dart';

import 'logger_interceptor.dart';

final sl = GetIt.instance;
Future<void> init() async {

 Dio client = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: 50000,
      receiveTimeout: 30000,
      responseType: ResponseType.json,
      baseUrl: '${Endpoints.baseUrl}',
      contentType: 'application/json',
    ),
  );
 sl.registerLazySingleton<Dio>(() => client);

 client..interceptors..interceptors.addAll([

   DioInterceptor(),
   if (kDebugMode) LoggerInterceptor(),
 ]);
  sl.registerLazySingleton(() => AppConfig());
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton(() => LoginRepository());
  sl.registerLazySingleton(() => SettingRepository());
  sl.registerLazySingleton(() => HomeRepository());


  sl.registerLazySingleton(() => HomeProvider());
  sl.registerLazySingleton(() => SettingProvider());
  sl.registerLazySingleton(() => AuthProvider());
  sl.registerLazySingleton<HttpAuth>(() => HttpAuth(client: sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<SharedLocal>(
        () => SharedLocal(
      sharedPreferences: sl(),
    ),
  );
}

