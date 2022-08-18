import 'package:dio/dio.dart';
import '../../components/const.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? qary,
      String? token,
      String lang = 'en'}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return dio.get(url, queryParameters: qary);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? qary,
      required Map<String, dynamic>? sendDate,
      String? token,
      String lang = 'en'}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return dio.post(url, data: sendDate);
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? qary,
      required Map<String, dynamic>? sendDate,
      required String? token,
      String lang = 'en'}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return dio.put(url, data: sendDate);
  }

  static Future<Response> remove(
      {required String url,
        Map<String, dynamic>? qary,
        Map<String, dynamic>? sendDate,
        required String? token,
        String lang = 'en'}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return dio.delete(url, data: sendDate);
  }


}
