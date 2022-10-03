import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:notey/features/Registrations/auth_provider.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/resources/assets_manager.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/shared/widgets/CustomeSvg.dart';

class CustomeSettingItemModel {
  String title;
  bool redColor;
  String? path;
  void Function()? onPressed;

  CustomeSettingItemModel(
      {this.path, this.onPressed, required this.title, this.redColor = false});
}

List<CustomeSettingItemModel> SettingItems = [
  CustomeSettingItemModel(
      onPressed: () {
        sl<NavigationService>().navigateTo(Routes.typographyScreen);
      },
      path: IconAssets.setting,
      title: "Typography"),
  CustomeSettingItemModel(
      onPressed: () {
        sl<SettingProvider>().languageSheet(sl<HomeProvider>().ScaffoldKeySheet);
// sl<Provider>(). getAddressProvider();
      },
      path:IconAssets.language,
      title: "Language"),
  CustomeSettingItemModel(
      onPressed: () {
        // sl<NavigationService>().navigateTo(terms);
      },
      path: IconAssets.privacy,
      title: "Privacy"),
  CustomeSettingItemModel(
      onPressed: () {
        sl<NavigationService>().navigateTo(Routes.helpCenter);
      },
      path:IconAssets.help,
      title: "Help center"),
  CustomeSettingItemModel(
      onPressed: () {
        sl<NavigationService>().navigateTo(Routes.contactus);
      },
      path: IconAssets.profile,
      title: "Contact Us"),
  CustomeSettingItemModel(
      onPressed: () {
        sl<NavigationService>().navigateTo(Routes.contactus);
      },
      path: IconAssets.dangerCircle,
      title: "Abouts"),
  CustomeSettingItemModel(
    redColor: sl<SharedLocal>().getUser().token != "" ? true : false,
    onPressed: () {
      if (sl<SharedLocal>().getUser().token == null) {
        sl<NavigationService>().navigateTo(Routes.login);
      } else {
        // sl<SettingProvider>().logoutProvider();
        showDialog(
          context: sl<AuthProvider>().scaffoldKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: Text('Logout'.tr()),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    sl<NavigationService>().pop();
                  },
                  child: Text(
                    'No'.tr(),
                    style: TextStyle(color: ColorManager.lightGrey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    sl<SettingProvider>().logoutProvider();
                  },
                  child: Text(
                    'Logout'.tr(),
                    style: TextStyle(
                        color: sl<SharedLocal>().getUser().token != ""
                            ? ColorManager.red
                            : ColorManager.primary),
                  ),
                ),
              ],
            );
          },
        );
      }
    },
    path: IconAssets.logout,

    // CustomSvgAssets(
    //   path: IconAssets.logout,
    //   color:
    //   sl<SharedLocal>().getUser().token != ""
    //       ? ColorManager.red
    //       : ColorManager.primary,
    // ),
    title: sl<SharedLocal>().getUser().token != "" ? 'Logout' : 'Login',
  ),
];
