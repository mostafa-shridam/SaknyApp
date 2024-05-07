import 'package:dio/dio.dart';


class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://console.firebase.google.com/',
        method: 'project/sakny-c00c7/firestore/data/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio?.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response?> postData({
    required String url,
    required String data,
    Map<String, dynamic>? query,
  }) async {
    return await dio?.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
