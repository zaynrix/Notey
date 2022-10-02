import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:notey/features/Registrations/auth_provider.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:notey/interceptors/dio_interceptor.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/routing/router.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/resources/theme_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await init();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark),
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        // Locale('de'),
      ],
      path: 'assets/translations',
      startLocale: Locale("en"),
      fallbackLocale: const Locale("en"),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: sl<HomeProvider>(),
            ),
            ChangeNotifierProvider.value(
              value: sl<AuthProvider>(),
            ),
            ChangeNotifierProvider.value(
              value: sl<SettingProvider>(),
            ),
            ChangeNotifierProvider.value(
              value: sl<AppConfig>(),
            ), ChangeNotifierProvider.value(
              value: sl<DioInterceptor>(),
            ),
          ],
          // yahya123123@gmail.comsn
          // password yahya123321
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            scaffoldMessengerKey: sl<NavigationService>().snackBarKey,
            debugShowCheckedModeBanner: false,
            title: 'Notey',
            theme: getApplicationTheme(),
            navigatorKey: sl<NavigationService>().navigatorKey,
            initialRoute: Routes.splash,
            onGenerateRoute: RouterX.generateRoute,
          ),
        );
      },
    );
  }
}
