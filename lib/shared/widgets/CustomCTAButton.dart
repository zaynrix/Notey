// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeCTAButton extends StatelessWidget {
  bool trigger;
  bool haveWidget;
  double heighbox;
  Widget? widget;
  bool haveBorder;
  Color colorBorder;
  Color? primary;
  Color? textColor;
  String? title;
  Color? ProgressColor;
  final Gradient gradient;

  void Function()? onPressed;
  double fontSized;
  Color? color;
  CustomeCTAButton(
      {Key? key,
      this.widget,
      this.heighbox = 44,
      this.fontSized = 17,
      this.haveWidget = true,
      this.haveBorder = false,
      this.colorBorder = ColorManager.lightGrey,
      this.ProgressColor = ColorManager.white,
      this.trigger = true,
      this.title,
      this.primary,
      this.onPressed,
        this.gradient = const LinearGradient(colors: [ColorManager.secondery,ColorManager.primary2 ]),

        this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: heighbox.h,
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  side: haveBorder
                      ? BorderSide(
                          width: 1.0,
                          color: colorBorder,
                        )
                      : BorderSide(
                          width: 0.0,
                          color: ColorManager.parent,
                        ),
                  borderRadius: BorderRadius.circular(6.r)),
            ),
            onPressed: onPressed,
            child: !trigger
                ? haveWidget
                    ? FittedBox(
                        child: Text(
                          title!.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: textColor, fontSize: fontSized),
                        ),
                      )
                    : widget
                : FittedBox(
                    child: CircularProgressIndicator(
                      color: ProgressColor,
                    ),
                  )));
  }
}

class CustomeCTAButtonCancel extends StatelessWidget {
  bool trigger;
  bool haveWidget;
  double heighbox;
  Widget? widget;
  bool haveBorder;
  Color colorBorder;
  Color? primary;
  Color? textColor;
  String? title;
  Color? ProgressColor;
  final Gradient gradient;

  void Function()? onPressed;
  double fontSized;
  Color? color;
  CustomeCTAButtonCancel(
      {Key? key,
        this.widget,
        this.heighbox = 44,
        this.fontSized = 17,
        this.haveWidget = true,
        this.haveBorder = false,
        this.colorBorder = ColorManager.lightGrey,
        this.ProgressColor = ColorManager.white,
        this.trigger = true,
        this.title,
        this.primary,
        this.onPressed,
        this.gradient = const LinearGradient(colors: [ColorManager.secondery,ColorManager.primary2 ]),

        this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: heighbox.h,
        decoration: BoxDecoration(
          color: color,
          // gradient: gradient,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  side: haveBorder
                      ? BorderSide(
                    width: 1.0,
                    color: colorBorder,
                  )
                      : BorderSide(
                    width: 0.0,
                    color: ColorManager.parent,
                  ),
                  borderRadius: BorderRadius.circular(6.r)),
            ),
            onPressed: onPressed,
            child: !trigger
                ? haveWidget
                ? FittedBox(
              child: Text(
                title!.tr(),
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: textColor, fontSize: fontSized),
              ),
            )
                : widget
                : FittedBox(
              child: CircularProgressIndicator(
                color: ProgressColor,
              ),
            )));
  }
}
