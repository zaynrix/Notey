import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/resources/assets_manager.dart';
import 'package:notey/utils/appConfig.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen() {
    // print("this inside Splash Screen");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(ImageAssets.splashLogoPng,width: MediaQuery.of(context).size.width * 0.5,),

          ],
        ),
      ),
    );
  }
}
