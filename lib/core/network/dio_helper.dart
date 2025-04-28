import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dioInstance;

  static void init() {
    dioInstance = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.in/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dioInstance.post(url, data: data);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    return await dioInstance.get(url, data: data);
  }
}
