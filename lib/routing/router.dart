import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:notey/features/splashScreen.dart';
import 'package:notey/features/Home/homeScreen.dart';
import 'package:notey/features/onBoardingScreen.dart';
import 'package:notey/features/Settings/typography.dart';
import 'package:notey/features/Settings/settingScreen.dart';
import 'package:notey/features/Settings/contactUsScreen.dart';
import 'package:notey/features/Registrations/loginScreen.dart';
import 'package:notey/features/Registrations/signUpScreen.dart';
import 'package:notey/features/Registrations/auth_provider.dart';
import 'package:notey/features/Registrations/forgetPasswordScreen.dart';
import 'package:notey/features/Registrations/createNewPasswordScreen.dart';

class RouterX {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {


    // ------------- Splash Screen ---------------

      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AppConfig>(),
            child: SplashScreen(),
          ),
        );


    // ------------- Introduction Screens ---------------
      case Routes.intro:
        return MaterialPageRoute(
          builder: (_) => const Introduction(),
        );


    // ------------- Login Screen ---------------
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AuthProvider>(),
            child: LoginScreen(),
          ),
        );


    // ------------- Forget Password Screen ---------------
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AuthProvider>(),
            child: ForgetPassword(),
          ),
        );

    // ------------- Create Password Screen ---------------

      case Routes.createNewPassword:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AuthProvider>(),
            child: CreateNewPassword(),
          ),
        );

    // ------------- Signup Screen ---------------

      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AuthProvider>(),
            child: Signup(),
          ),
        );

    // ------------- Home Screen ---------------

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

    // ------------- Settings Screen ---------------

      case Routes.setting:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );

    // ------------- Theme Screen ---------------

      case Routes.typographyScreen:
        return MaterialPageRoute(
          builder: (_) => TypographyScreen(),
        );

        // ------------- Contact Us Screen ---------------
      case Routes.contactus:
        return MaterialPageRoute(
          builder: (_) => ContactUsScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
