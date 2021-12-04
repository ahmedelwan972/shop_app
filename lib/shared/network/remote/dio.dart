import 'dart:async';

import 'package:ayop01/models/shop_login_models/shop_user_models.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static late Response response;

  static void init1() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveTimeout: 5000,
        connectTimeout: 5000,
      ),
    );
  }

  static Future<Response> getData(
      {required String url,
        Map<String, dynamic>? query,
        String? token,
        String lang = 'en',
      }) async {

    dio.options.headers =
    {
      'lang' : lang,
      'Authorization':token ,
      'Content-Type': 'application/json'
    };
    return response = await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String , dynamic> data,
    String? token,
    String lang = 'en',


  }) async {
    dio.options.headers =
    {
      'lang' : lang,

      'Authorization':token ,
      'Content-Type': 'application/json'
    };
    return response = await dio.post(url, data: data);
  }

  static Future<Response> putData({
    required String url,
    required Map<String , dynamic> data,
    String? token,
    String lang = 'en',


  }) async {
    dio.options.headers =
    {
      'lang' : lang,
      'Authorization':token ,
      'Content-Type': 'application/json'
    };
    return response = await dio.put(url, data: data);
  }
}
