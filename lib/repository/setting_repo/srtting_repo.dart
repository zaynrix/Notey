import 'package:notey/api/endPoints.dart';
import 'package:notey/api/remote/auth_api.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/loginModel.dart';

class SettingRepository{

  Future<LoginResponse> logout() async {
    print("get Tasks Repo");
    final response = await sl<HttpAuth>().getData(
      url: Endpoints.tasks,
    );
    LoginResponse loginResponse = LoginResponse.fromJson(response.data);
    print("This is task response ${response.data}");

    if (loginResponse.status == true) {
      return loginResponse;
    }
    throw '${loginResponse.message}';
  }

}