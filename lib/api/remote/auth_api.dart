import 'package:dio/dio.dart';

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
