import 'package:notey/api/endPoints.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/api/remote/auth_api.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/loginModel.dart';

class LoginRepository {
  Future<LoginResponse> userLogin({
    required String email,
    required String password,
  }) async {
    final response = await sl<HttpAuth>().postData(
      url: Endpoints.auth + Endpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    LoginResponse loginResponse = LoginResponse.fromJson(response.data);

    if (loginResponse.status == true) {
      return loginResponse;
    }
    throw '${loginResponse.message}';
  }

  Future<LoginResponse> userSignup({
    required String name,
    required String email,
    required String gender,
    required String password,
  }) async {
    final response = await sl<HttpAuth>().postData(
      url: "${Endpoints.auth}" "${Endpoints.signUp}",
      data: {
        'email': email, // yahya1@gmail.com
        'password': password, // yahya123
        'full_name': name, // yahya
        'gender': gender.toUpperCase(), // M
      },
    );
    LoginResponse loginResponse = LoginResponse.fromJson(response.data);

    return loginResponse;
  }

  Future<LoginResponse> userForgetPassword({
    required String email,
  }) async {
    final response = await sl<HttpAuth>().postData(
      url: "${Endpoints.auth}" "${Endpoints.forgetPassword}",
      data: {
        'email': email,
      },
    );
    LoginResponse loginResponse = LoginResponse.fromJson(response.data);

    return loginResponse;
  }

  Future<LoginResponse> changePassword(
      {String? currentPassword, String? newPassword}) async {
    final response = await sl<HttpAuth>().postData(
      url: "${Endpoints.auth}" "${Endpoints.resetPassword}",
      data: {
        "email": "${sl<SharedLocal>().getSignUpTempo()}",
        "code": "${sl<SharedLocal>().geCode}",
        "password": "$currentPassword",
        "password_confirmation": "$newPassword",
      },
    );

    LoginResponse users = LoginResponse.fromJson(response.data);
    return users;
  }
}
