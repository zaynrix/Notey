// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/resources/assets_manager.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/resources/font_manager.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/shared/widgets/CustomeSvg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final Widget? leading;
  List<Widget>? actions;
  Color? backgroundColor;

  CustomAppBar({
    this.backgroundColor = ColorManager.backgroundColor,
    this.leading,
    required this.title,
    this.actions,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      title: Text(
        "${title.tr()}",
        style: TextStyle(color: ColorManager.white, fontSize: FontSize.s40.sp),
      ),
      centerTitle: false,
      actions: actions,

      backgroundColor: backgroundColor,
    );
  }
}
