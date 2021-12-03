import 'package:dio/dio.dart';

Dio dio() {
  var dio = Dio(BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/flutter_sanctum/',
      responseType: ResponseType.plain,
      headers: {
        'accpt': 'application/json',
        'content/type': 'application/json',
      }));
  return dio;
}
