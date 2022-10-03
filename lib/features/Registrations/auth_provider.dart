import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notey/routing/routes.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/loginModel.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/repository/user_repo/login_repo.dart';

class AuthProvider extends ChangeNotifier {
  // ------------------ Login - Forget - Signup  ------------------
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // ------------------  Signup  ------------------
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();

  // ------------------  Forms Key  ------------------
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool hasError = false;
  bool isObscure = true;
  bool rememberMe = true;

  String? keyGender;
  Map<String, String>? selectedGender;

  List<Map<String, String>> gender = [
    {"M": "Male"},
    {"F": "Female"}
  ];

  // ------------------ Remember Me ------------------
  void remember(bool value) {
    rememberMe = value;
    notifyListeners();
  }

  // ------------------ Password Visibility ------------------
  void visibility() {
    isObscure = !isObscure;
    notifyListeners();
  }

  // ------------------ Select Gender ------------------
  void selectGender(selected) {
    selectedGender = selected;
    selectedGender!.forEach((key, value) {
      keyGender = key;
      notifyListeners();
    });
  }

  // ------------------ Login ------------------
  Future<void> loginProvider() async {
    if (formKey.currentState!.validate()) {
      try {
        loading = true;
        notifyListeners();
        LoginResponse res = await sl<LoginRepository>().userLogin(
            email: emailController.text, password: passwordController.text);
        // if (res.status == true && res.object != null) {
        sl<SharedLocal>().setUser(res.object!);
        sl<NavigationService>().navigateToAndRemove(Routes.home);
        AppConfig.showSnakBar("Logged",Success: true);
        // } else {
        //   AppConfig.showSnakBar("${res.message}");
        // }
      } on DioError catch (e) {
        AppConfig().showException(e);
      }
      loading = false;
      notifyListeners();
    }
  }

  // ------------------ Sign Up Provider ------------------

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
        AppConfig.showSnakBar(
            "${res.message ?? "Account was created Successfully!!"}");
        sl<NavigationService>().navigateToAndRemove(Routes.login);
      } on DioError catch (e) {
        AppConfig().showException(e);
      }
      loading = false;
      notifyListeners();
    }
  }

  // ------------------ Forget Provider ------------------

  Future<void> forgetProvider() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      try {
        LoginResponse res = await sl<LoginRepository>()
            .userForgetPassword(email: emailController.text);

        sl<SharedLocal>().setSignUpTempo("${emailController.text}");
        sl<SharedLocal>().setCode = res.code!;
        AppConfig.showSnakBar("${res.message}",Success: true);
        sl<NavigationService>().navigateToAndRemove(Routes.createNewPassword);

        // AppConfig.showSnakBar("Something Wrong, Try again");
      } on DioError catch (e) {
        AppConfig().showException(e);
      }
      loading = false;
      notifyListeners();
    }
  }

  // ------------------ Change Password Provider ------------------

  void changePasswordProvider() async {
    if (formKey2.currentState!.validate()) {
      loading = true;
      notifyListeners();
      try {
        LoginResponse response = await sl<LoginRepository>().changePassword(
            currentPassword: currentPass.text, newPassword: newPass.text);
        AppConfig.showSnakBar("${response.message}",Success: true);
        sl<NavigationService>().navigateToAndRemove(Routes.login);
      } on DioError catch (e) {
        AppConfig().showException(e);
      }
      loading = false;
      notifyListeners();
    }
  }
}
