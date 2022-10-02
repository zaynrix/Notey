import 'package:flutter/material.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:notey/features/Home/homeScreen.dart';
import 'package:notey/features/Registrations/auth_provider.dart';
import 'package:notey/features/Registrations/createNewPasswordScreen.dart';
import 'package:notey/features/Registrations/forgetPasswordScreen.dart';
import 'package:notey/features/Registrations/loginScreen.dart';
import 'package:notey/features/Registrations/signUpScreen.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:notey/features/Settings/settingScreen.dart';
import 'package:notey/features/Settings/typography.dart';
import 'package:notey/features/onBoardingScreen.dart';
import 'package:notey/features/splashScreen.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/shared/widgets/CustomeBottomSheet.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:provider/provider.dart';

class RouterX {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AppConfig>(),
            child: SplashScreen(),
          ),
        );
      case Routes.intro:
        return MaterialPageRoute(
          builder: (context) => const Introduction(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => AuthProvider(),
            child: LoginScreen(),
          ),
        );

      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AuthProvider>(),
            child: ForgetPassword(),
          ),
        ); case Routes.createNewPassword:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AuthProvider>(),
            child: CreateNewPassword(),
          ),
        );
      // case Routes.bottomSheet:
      //   return MaterialPageRoute(
      //     builder: (_) => ChangeNotifierProvider(
      //       create: (context) => HomeProvider(),
      //       child: BottomSheetNote(),
      //     ),
      //   );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => AuthProvider(),
            child: Signup(),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<HomeProvider>(),
            child: HomeScreen(),
          ),
        );  case Routes.setting:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<SettingProvider>(),
            child: SettingsScreen(),
          ),
        );
      case Routes.typographyScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AppConfig>(),
            child: TypographyScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
