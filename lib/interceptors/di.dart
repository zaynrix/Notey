import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:notey/interceptors/retry_interceptor.dart';

import 'dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:notey/api/endPoints.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/api/remote/auth_api.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:notey/features/Registrations/auth_provider.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:notey/interceptors/connect.dart';
import 'package:notey/repository/home_repo/task_repo.dart';
import 'package:notey/repository/setting_repo/srtting_repo.dart';
import 'package:notey/repository/user_repo/login_repo.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // Dio? dio;

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
   RetryOnConnectionChangeInterceptor(dio: sl(),connectivity: Connectivity())
   // RetryOnConnectionChangeInterceptor(dio!)
   // CacheInterceptor(),
   // LoggerInterceptor(),
 ]);
// client..interceptors.add();
  sl.registerLazySingleton(() => AppConfig());
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton(() => LoginRepository());
  sl.registerLazySingleton(() => SettingRepository());
  sl.registerLazySingleton(() => HomeRepository());




  sl.registerLazySingleton(() => Connection());
  sl.registerLazySingleton(() => HomeProvider());
  sl.registerLazySingleton(() => SettingProvider());
  sl.registerLazySingleton(() => AuthProvider());
  sl.registerLazySingleton<HttpAuth>(() => HttpAuth(client: sl()));
  // sl.registerLazySingleton<RetryOnConnectionChangeInterceptor>(() => RetryOnConnectionChangeInterceptor(dio: sl(),connectivity: Connectivity()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<SharedLocal>(
        () => SharedLocal(
      sharedPreferences: sl(),
    ),
  );
}

