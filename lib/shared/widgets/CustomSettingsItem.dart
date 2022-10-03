// ignore_for_file: unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/resources/assets_manager.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/shared/widgets/CustomeSvg.dart';

class CustomeSettingItem extends StatelessWidget {
  final String title;
  final Widget? path;
  final String? path2;
  final bool redColor;
  void Function()? onPressed;

  CustomeSettingItem(
      {Key? key,
      this.path2,
      required this.title,
      this.onPressed,
      this.path,
      this.redColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: ListTile(
            leading: CustomSvgAssets(
                path: path2,
                color: sl<SettingProvider>()
                    .CCC[sl<SettingProvider>().colorIndex][0]),
            title: Text(
              title.tr(),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: !redColor ? ColorManager.white : ColorManager.red),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: ColorManager.black,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0.r),
          ),
        ),
      ),
    );
  }
}
