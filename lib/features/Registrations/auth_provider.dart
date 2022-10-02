import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notey/api/remote/auth_api.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:notey/interceptors/dio_exception.dart';
import 'package:notey/repository/setting_repo/srtting_repo.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/loginModel.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/repository/user_repo/login_repo.dart';

class AuthProvider extends ChangeNotifier {
  //Login / Signup Controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Signup Controller
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();

//
  TextEditingController pinController = TextEditingController();
  TextEditingController phoneVerficationController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool rememberMe = true;
  bool isObscure = true;
  bool hasError = false;

  String currentText = "";
  List<Map<String, String>> gender = [
    {"M": "Male"},
    {"F": "Female"}
  ]; // Option 2
  Map<String, String>? selectedGender; // Option 2
  String? keyGender;

  void changeLoaderInterceptor() {
    loading = false;
    notifyListeners();
  }

  void remmberMe(bool value) {
    rememberMe = value;
    notifyListeners();
  }

  void visibility() {
    isObscure = !isObscure;
    notifyListeners();
  }

  void selectNumber(selected) {
    print("this is selected $selected");
    selectedGender = selected;
    selectedGender!.forEach((key, value) {
      keyGender = key;
      notifyListeners();
    });
    print("this is selectedGender ${selectedGender!.keys.toString()}");
    notifyListeners();
  }

  // Login
  Future<void> loginProvider() async {
    if (formKey.currentState!.validate()) {
      try {
        loading = true;
        notifyListeners();
        LoginResponse res = await sl<LoginRepository>().userLogin(
            email: emailController.text, password: passwordController.text);

        if (res.status == true && res.object != null) {
          sl<SharedLocal>().setUser(res.object!);
          sl<NavigationService>().navigateToAndRemove(Routes.home);
          AppConfig.showSnakBar("Logged");
        } else {
          AppConfig.showSnakBar("${res.message}");
        }
      } on DioError catch (e) {
        AppConfig().showException(e);
      }
      loading = false;
      notifyListeners();
    }
  }

  Future<void> SignupProvider() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      try {
        LoginResponse res = await sl<LoginRepository>().userSignup(
            name: fullname.text,
            email: emailController.text,
            password: passwordController.text,
            gender: keyGender!);
        if (res.status == true) {
          AppConfig.showSnakBar(
              "${res.message ?? "Account was created Successfully!!"}");
          sl<NavigationService>().navigateToAndRemove(Routes.login);
        } else {
          AppConfig.showSnakBar(
              "${res.message ?? "Something Wrong, Try again"}");
        }
      } on DioError catch (e) {
        AppConfig().showException(e);
      }
      loading = false;
      notifyListeners();
    }
  }

  Future<void> forgetProvider() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      try {
        LoginResponse res = await sl<LoginRepository>()
            .userForgetPassword(email: emailController.text);

        if (res.status == true) {
          loading = false;
          notifyListeners();
          //yahya.m.abunada@gmail.comsn
          sl<SharedLocal>().setSignUpTempo("${emailController.text}");
          sl<SharedLocal>().setCode = res.code!;
          AppConfig.showSnakBar("${res.message}");
          // AppConfig.showSnakBar("${res.code}");
          //
          sl<NavigationService>().navigateToAndRemove(Routes.createNewPassword);
        } else if (res.status != true) {
          loading = false; //1234
          notifyListeners();
          AppConfig.showSnakBar(res.message!);
        } else {
          loading = false;
          notifyListeners();
          AppConfig.showSnakBar("Something Wrong, Try again");
        }
      } on DioError catch (e) {
        AppConfig().showException(e);
      }
    }
  }

  void changePasswordProvider() async {
    if (formKey2.currentState!.validate()) {
      loading = true;
      notifyListeners();
      try {
        LoginResponse response = await sl<LoginRepository>().changePassword(
            currentPassword: currentPass.text, newPassword: newPass.text);
        if (response.status == true) {
          AppConfig.showSnakBar("${response.message}");
          loading = false;
          notifyListeners();

          sl<NavigationService>().navigateToAndRemove(Routes.login);
        } else {
          AppConfig.showSnakBar("${response.message}");
          loading = false;
          notifyListeners();
        }
      } on DioError catch (e) {
        AppConfig().showException(e);
      }
    }
  }
}
