import 'package:flutter/material.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/loginModel.dart';
import 'package:notey/repository/setting_repo/srtting_repo.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/shared/widgets/CustomeBottomSheet.dart';
import 'package:notey/utils/appConfig.dart';

class SettingProvider extends ChangeNotifier {
  int languageValue = 0;
  double textSize = 5;


  Future<void> logoutProvider() async {
    LoginResponse res = await sl<SettingRepository>().logout();

    if (res.status == true) {
      sl<SharedLocal>().removeUser();
      sl<NavigationService>().navigateToAndRemove(Routes.login);

      // sl<SettingProvider>().clearUserData();

      AppConfig.showSnakBar("${res.message}");
    } else {
      AppConfig.showSnakBar("Something Wrong ");
    }
  }


  changeLanguage(value) {
    languageValue = value;
    (languageValue);
    notifyListeners();
  }

  changeSize(double size){
      textSize = size;
      notifyListeners();
  }


  void languageSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: ColorManager.darkGrey,
      context: sl<HomeProvider>().sheetScafoldKey.currentContext!,
      builder: (context) => BottomSheetLanguage(),
    );
  }

}
