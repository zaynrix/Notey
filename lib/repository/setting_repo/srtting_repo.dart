import 'dart:convert';

import 'package:notey/api/endPoints.dart';
import 'package:notey/api/remote/auth_api.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/contactUsModel.dart';
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


  Future<ContactUs> getContactUs() async {
    final response = '''

{
    "status": true,
    "message": "null",
    "data": {
        "current_page": 1,
        "data": [
            {
                "id": 1,
                "type": 3,
                "value": "https://www.facebook.com/zaynrix/",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Facebook.png"
            },
            {
                "id": 2,
                "type": 3,
                "value": "https://www.instagram.com/yahya.m.abunada/",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Instagram.png"
            },
            {
                "id": 3,
                "type": 3,
                "value": "https://twitter.com/UxuiYahya",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Twitter.png"
            },
            {
                "id": 4,
                "type": 2,
                "value": "mailto:yahya.m.abunada@gmail.com",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Email.png"
            },
            {
                "id": 5,
                "type": 1,
                "value": "tel://+970592487533",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Phone.png"
            },
            {
                "id": 6,
                "type": 3,
                "value": "http://wa.me/970592487533",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Whatsapp.png"
            },
            {
                "id": 7,
                "type": 3,
                "value": "https://snapchat.com",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Snapchat.png"
            },
            {
                "id": 8,
                "type": 3,
                "value": "https://youtube.com",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Youtube.png"
            }
           
        ],
        "first_page_url": "https://student.valuxapps.com/api/contacts?page=1",
        "from": 1,
        "last_page": 1,
        "last_page_url": "https://student.valuxapps.com/api/contacts?page=1",
        "next_page_url": null,
        "path": "https://student.valuxapps.com/api/contacts",
        "per_page": 35,
        "prev_page_url": null,
        "to": 9,
        "total": 9
    }
}
''';
    Map<String, dynamic> jsonList = jsonDecode(response);

    ContactUs aboutUs = ContactUs.fromJson(jsonList);
    return aboutUs;
  }

}