import '../Home/homeProvider.dart';
import 'package:flutter/material.dart';
import 'package:notey/models/users.dart' as user;
import 'package:notey/routing/routes.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:notey/models/loginModel.dart';
import 'package:notey/routing/navigation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/models/contactUsModel.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/shared/widgets/CustomeBottomSheet.dart';
import 'package:notey/repository/setting_repo/srtting_repo.dart';


class SettingProvider extends ChangeNotifier {

  int languageValue = 0;
  int colorIndex = 0;

  double textSize = 5;

  // Data
  List<user.Data> users = [];
  List<ContactUsData> contactUsData = [];

  List<List<Color>> CCC = [
    [ColorManager.primary, ColorManager.secondery,],
    [ColorManager.starYellow, ColorManager.darkGrey],
    [ColorManager.red, ColorManager.darkGrey],
    [ColorManager.secondery, ColorManager.lightGrey],
    [ColorManager.secondryBlack, ColorManager.strokSuger],
  ];

  // ------------------ Logout ------------------
  Future<void> logoutProvider() async {
      LoginResponse res = await sl<SettingRepository>().logout();
      sl<SharedLocal>().removeUser();
      sl<HomeProvider>().tasks!.clear();
      notifyListeners();
      sl<NavigationService>().navigateToAndRemove(Routes.login);
      AppConfig.showSnakBar("${res.message}", Success: true);
  }

  // ------------------ Change Language ------------------
  changeLanguage(value) {
    languageValue = value;
    notifyListeners();
  }

  // ------------------ Change Note Text Size ------------------
  changeSize(double size) {
    textSize = size;
    sl<SharedLocal>().setFontSize = size;
    notifyListeners();
  }

  // ------------------ Change Note ColorIndex  ------------------

  changeIndexColor(int index) {
    colorIndex = index;
    sl<SharedLocal>().setColorIndex = index;
    notifyListeners();
  }

  // ------------------ Bottom Language Sheet ------------------
  void languageSheet(GlobalKey? ScaffoldKeySheet) {
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
    notifyListeners();
    contactUsData.forEach((element) => ("${element.id} -${element.value}"));
    notifyListeners();
  }
  // ------------------ Get Users Data ------------------
  void getUsersProvider() async {
    user.Users response = await sl<SettingRepository>().getUsers();
    users = response.usersList!;
    notifyListeners();
    users.forEach((element) => ("${element.id} -${element.image}"));
    notifyListeners();
  }

  // ------------------ Lunch URL ------------------
  Future<void> launchUrlSite(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
