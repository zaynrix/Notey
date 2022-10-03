import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notey/features/Registrations/auth_provider.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/resources/assets_manager.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/resources/font_manager.dart';
import 'package:notey/resources/styles_manager.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/shared/widgets/CustomCTAButton.dart';
import 'package:notey/shared/widgets/CustomeSvg.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:notey/utils/validator.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../shared/widgets/CustomeRoundedTextFiled.dart';

class Signup extends StatelessWidget {
  Signup(){
    print("This is Signup");

  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<AuthProvider>(
          builder: (context, peovider, _) => Scaffold(
              body: Form(
            key: peovider.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 85.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign'.tr(),
                          style: AppConfig()
                              .getTextContext(context)
                              .headline2!
                              .copyWith(fontSize: FontSize.s40.sp),
                        ),
                        GradientText(
                          'Up'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: FontSize.s40.sp,
                                  fontWeight: FontWeightManager.semiBold),
                          colors: const [
                            ColorManager.secondery,
                            ColorManager.primary,
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "CreateAcc".tr(),
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontSize: FontSize.s24.sp,
                          color: ColorManager.fadeGrey),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextFiled(
                      prefixIcon: CustomSvgAssets(
                        path: IconAssets.profile,
                        color: ColorManager.primary,
                      ),
                      hintText: 'Fullname',
                      keyboardType: TextInputType.emailAddress,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        peovider.fullname.text = val!;
                      },
                      validator: (value) => Validator.valueExists(value ?? ""),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    CustomTextFiled(
                      prefixIcon: CustomSvgAssets(
                        path: IconAssets.email,
                        color: ColorManager.primary,
                      ),
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        peovider.emailController.text = val!;
                      },
                      validator: (value) =>
                          Validator2.validateEmail(value ?? ""),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    CustomTextFiled(

                      prefixIcon: Container(
                        // width: 80,
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            dropdownColor: ColorManager.darkGrey,
                            //<-- SEE HERE

                            // iconEnabledColor: ColorManager.secondryBlack,
                            // dropdownColor: ColorManager.backgroundColor,

                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: ColorManager.primary,
                            ),
                            underline: Container(),
                            hint: Text(
                              'Gender',
                              style: getRegularStyle(
                                  color: ColorManager.lightGrey,
                                  fontSize: FontSize.s16.sp),
                            ),
                            // Not necessary for Option 1
                            value: peovider.selectedGender,
                            onChanged: (newValue) {
                              print("This is new Value $newValue");
                              peovider.selectGender(newValue);
                            },
                            items: peovider.gender.map((location) {
                              return DropdownMenuItem(
                                child: new Text(
                                  "${location.values}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: ColorManager.primary),
                                ),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      hintText: '',
                      keyboardType: TextInputType.phone,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        // peovider.phone.text = val!;
                      },
                      validator: (value) =>
                          peovider.selectedGender == null ? "" : null,
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    CustomTextFiled(
                      suffixIcon: CustomSvgAssets(
                        color: ColorManager.primary,
                        path: IconAssets.hide,
                      ),
                      prefixIcon: CustomSvgAssets(
                        color: ColorManager.primary,
                        path: IconAssets.lock,
                      ),
                      hintText: 'password',
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        peovider.passwordController.text = val!;
                      },
                      validator: (value) =>
                          Validator2.validatePassword(value ?? ""),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    // 059
                    CustomTextFiled(
                      suffixIcon: CustomSvgAssets(
                        color: ColorManager.primary,
                        path: IconAssets.hide,
                      ),
                      prefixIcon: CustomSvgAssets(
                        color: ColorManager.primary,
                        path: IconAssets.lock,
                      ),
                      hintText: 'ConfirmPassword',
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.done,
                      onChanged: (val) {
                        peovider.confirmPasswordController.text = val!;
                      },
                      validator: (val) {
                        if (val!.isEmpty) return 'Empty'.tr();
                        if (val != peovider.passwordController.text)
                          return 'Not Match'.tr();
                        return null;
                      }, //0599147563
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Theme(
                            data: ThemeData(
                                unselectedWidgetColor: const Color(0xFF667085)),
                            child: Checkbox(
                              value: peovider.rememberMe,
                              checkColor: ColorManager.primary,
                              activeColor: ColorManager.secondryBlack,
                              onChanged: (value) {
                                peovider.remember(value!);
                              },
                            )),
                        Text('Agree with trams and condition'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: FontSize.s12.sp)),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomeCTAButton(
                      trigger: peovider.loading,
                      primary: ColorManager.secondryBlack,
                      onPressed: () {
                        peovider.SignupProvider();
                      },
                      title: "Sign Up",
                    ),
                    SafeArea(  // yahya123@gmail.com
                      // yahya123
                      bottom: true,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            sl<NavigationService>()
                                .navigateToAndRemove(Routes.login);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Haveanaccount'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: ColorManager.lightGrey),
                                ),
                                TextSpan(
                                  text: 'Login'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: ColorManager.primary,
                                          fontWeight:
                                              FontWeightManager.semiBold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}

//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//             RichText(
//               text:  TextSpan(children: [
//                 TextSpan(
//                   text: 'Sign',
//                   style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black,fontSize: FontSize.s40.sp),),
//                 TextSpan(
//                   text: 'Up',
//                   style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.green,fontSize: FontSize.s40.sp),),
//               ]),
//             ),
//
//
//
//             Text("Create a new account!"),
//             Text("This is Center"),
//           ],
//         )
//     );
//   }
// }
