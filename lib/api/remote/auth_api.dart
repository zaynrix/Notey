import 'package:dio/dio.dart';
import 'package:notey/api/endPoints.dart';
import 'package:notey/models/loginModel.dart';

class HttpAuth {
  final Dio client;

  HttpAuth({required this.client});

  //get data
   Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  })  {
    client.options.headers = {
      'Content-Type': 'application/json',
    };
    return  client.get(url, queryParameters: query);
  }

  //post data
   Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  })  {
     client.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };

    return  client.post(url, queryParameters: query, data: data);
  }

  //update data
   Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  })  {
     client.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };

    return  client.put(url, queryParameters: query, data: data);
  }

  //delete data
   Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  })  {
    client.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return  client.delete(url, queryParameters: query);
  }
}
  // Future<LoginResponse> SignupRepo({User? user}) async {
  //   print(user!.name);
  //   print("${user.introPhone}${user.phone}");
  //   Response response = await client.post(
  //     '${ApiConstant.authSignup}',
  //     data: {
  //       "email": "${user.email}",
  //       "phone": "${user.introPhone}${user.phone}",
  //       "name": "${user.name}",
  //       "password": "${user.password}",
  //     },
  //   );
  //
  //   // print("This is  realUri ${response.realUri}");
  //   // print("This is  respsBod ${response.statusCode}");
  //   LoginResponse users = LoginResponse.fromJson(response.data);
  //   return users;
  // }
  //
  // Future<LoginResponse> sendOTP({
  //   String? phone,
  //   String? otp,
  // }) async {
  //   print("sendOTP");
  //
  //   Response response = await client.put(
  //     '${ApiConstant.otpCode}',
  //     data: {
  //       "code": "$otp",
  //       "mobile": "$phone",
  //     },
  //   );
  //
  //   LoginResponse users = LoginResponse.fromJson(response.data);
  //   return users;
  // }
  //
  // Future<LoginResponse> reSendOTP({
  //   String? phone,
  // }) async {
  //   Response response = await client.post(
  //     '${ApiConstant.resendCode}',
  //     data: {
  //       "mobile": "$phone",
  //     },
  //   );
  //   LoginResponse users = LoginResponse.fromJson(response.data);
  //   return users;
  // }
  //
  // Future<LoginResponse> forgetRepo({String? email}) async {
  //   Response response = await client
  //       .post('${ApiConstant.forgetPassword}', data: {"email": email});
  //
  //   LoginResponse users = LoginResponse.fromJson(response.data);
  //   return users;
  // }
  //
  // Future<LoginResponse> confirmCodeRepo({String? email, String? otp}) async {
  //   print("Forget");
  //   Response response = await client.post(
  //     '${ApiConstant.confirmCodePassword}',
  //     data: {
  //       "code": "$otp", //1234
  //       "email": "$email",
  //     },
  //   );
  //   // print("This is  resps ${response.data}");
  //
  //   LoginResponse users = LoginResponse.fromJson(response.data);
  //   return users;
  // }
  //
  // Future<LogoutModel> logout({String? email, String? otp}) async {
  //   var token =
  //   await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
  //   // print("This is logout token $token");
  //   Response response = await client.post('${ApiConstant.logout}',
  //       options: Options(
  //         headers: <String, String>{
  //           "Authorization": "${token}",
  //           "lang": "${sl<SharedLocal>().getLanguage}",
  //         },
  //       ));
  //   // print("This is  resps ${response.data}");
  //
  //   LogoutModel logoutModel = LogoutModel.fromJson(response.data);
  //   return logoutModel;
  // }
  //
  // Future<LoginResponse> changePassword(
  //     {String? currentPassword, String? newPassword}) async {
  //   var token =
  //   await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
  //   Response response = await client.post(
  //     '${ApiConstant.changePassword}',
  //     data: {
  //       "current_password": "$currentPassword",
  //       "new_password": "$newPassword",
  //     },
  //     options: Options(
  //       headers: <String, String>{
  //         "Authorization": "$token",
  //         "lang": "${sl<SharedLocal>().getLanguage}",
  //       },
  //     ),
  //   );
  //   // print("This is  resps ${response.data}");
  //   // print("This is  respsBod ${response.statusCode}");
  //
  //   LoginResponse users = LoginResponse.fromJson(response.data);
  //   return users;
  // }
