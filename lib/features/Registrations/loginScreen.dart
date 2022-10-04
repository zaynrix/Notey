import 'package:flutter/material.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/resources/assets_manager.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/resources/font_manager.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/shared/widgets/CustomCTAButton.dart';
import 'package:notey/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:notey/shared/widgets/CustomeSvg.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:notey/utils/validator.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notey/features/Registrations/auth_provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Consumer<AuthProvider>(builder: (context, value, _) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
              key: value.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.s tart,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome".tr(),
                          style: AppConfig()
                              .getTextContext(context)
                              .headline2!
                              .copyWith(fontSize: FontSize.s40.sp),
                        ),
                        GradientText(
                          'back'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: FontSize.s40.sp,
                                  fontWeight: FontWeightManager.semiBold),
                          colors: sl<SettingProvider>().CCC[sl<SharedLocal>().getColorIndex]
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Image.asset(
                      ImageAssets.splashLogoPng,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextFiled(
                      prefixIcon: CustomSvgAssets(
                        color: sl<SettingProvider>().CCC[sl<SharedLocal>().getColorIndex][0],
                        path: IconAssets.profile,
                      ),
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        value.emailController.text = val!;
                      },
                      validator: (value) =>
                          Validator2.validateEmail(value ?? ""),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    CustomTextFiled(
                      obscureText: value.isObscure,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          value.visibility();
                        },
                        child: CustomSvgAssets(
                          color: sl<SettingProvider>().CCC[sl<SharedLocal>().getColorIndex][0],
                          path: value.isObscure
                              ? IconAssets.hide
                              : IconAssets.show,
                        ),
                      ),
                      prefixIcon: CustomSvgAssets(
                        color: sl<SettingProvider>().CCC[sl<SharedLocal>().getColorIndex][0],
                        path: IconAssets.lock,
                      ),
                      hintText: 'password',
                      focuse: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        value.passwordController.text = val!;
                      },
                      validator: (value) =>
                          Validator2.validatePassword(value ?? ""),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        sl<NavigationService>()
                            .navigateTo(Routes.forgetPassword);
                      },
                      child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            "Forget password".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: ColorManager.lightGrey),
                          )),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomeCTAButton(
                      trigger: value.loading,
                      onPressed: () {
                        // Login Function
                        value.loginProvider();
                      },
                      title: "Login",
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Spacer(),
                    SafeArea(
                      bottom: true,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            sl<NavigationService>()
                                .navigateToAndRemove(Routes.signUp);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'HaventAccount'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: ColorManager.lightGrey),
                                ),
                                TextSpan(
                                  text: 'SignUp'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          decoration: TextDecoration.underline,
                                          color: sl<SettingProvider>().CCC[sl<SharedLocal>().getColorIndex][0],
                                          fontWeight:
                                              FontWeightManager.semiBold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
