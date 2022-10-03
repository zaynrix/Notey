import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/contactUsModel.dart';
import 'package:notey/models/loginModel.dart';
import 'package:notey/repository/setting_repo/srtting_repo.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/shared/widgets/CustomeBottomSheet.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingProvider extends ChangeNotifier {


  int languageValue = 0;
  double textSize = 5;
  List<ContactUsData> contactUsData = [];


  // ------------------ Logout ------------------

  Future<void> logoutProvider() async {
    try {
      LoginResponse res = await sl<SettingRepository>().logout();
      sl<SharedLocal>().removeUser();
      sl<NavigationService>().navigateToAndRemove(Routes.login);
      // sl<SettingProvider>().clearUserData();
      AppConfig.showSnakBar("${res.message}",Success: true);

    } on DioError catch(e){
      AppConfig().showException(e);

    }

  }


  // ------------------ Change Language ------------------

  changeLanguage(value) {
    languageValue = value;
    notifyListeners();
  }


  // ------------------ Change Note Text Size ------------------

  changeSize(double size) {
    textSize = size;
    notifyListeners();
  }

  // ------------------ Bottom Language Sheet ------------------

  void languageSheet(GlobalKey?  ScaffoldKeySheet) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: ColorManager.darkGrey,
      context: ScaffoldKeySheet!.currentContext!,
      builder: (context) => BottomSheetLanguage(),
    );
  }


  // ------------------ Get Contact Data ------------------

  void getContactUsProvider() async {
    ContactUs response = await sl<SettingRepository>().getContactUs();
      contactUsData = response.data!.contactUsData!;
      contactUsData.forEach((element) => ("${element.id} -${element.value}"));
      notifyListeners();
  }



  // ------------------ Lunch URL ------------------

  Future<void> launchUrlSite(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
