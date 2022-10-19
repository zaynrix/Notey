import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/routing/router.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/resources/theme_manager.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await init();

  sl<AppConfig>().loadData();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark),
  );

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
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
        // final platformIsIOS = Platform.isIOS;

        return MultiProvider(
          providers: [
            StreamProvider<InternetConnectionStatus>(
                initialData: InternetConnectionStatus.connected,
                create: (_) {
                  return InternetConnectionChecker().onStatusChange;
                }),
            ChangeNotifierProvider.value(
              value: sl<HomeProvider>(),
            ),
            ChangeNotifierProvider.value(
              value: sl<SettingProvider>(),
            ),
          ],
          child:  MaterialApp(
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
