import 'package:dio/dio.dart';
import 'package:flutter_sanctum/providers/auth.dart';

Dio dio() {
  var dio = Dio(BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/flutter_sanctum/',
      responseType: ResponseType.plain,
      headers: {
        'accpt': 'application/json',
        'content/type': 'application/json',
      }));

  dio..interceptors.add(InterceptorsWrapper(
    on onRequest: (options) => requestInterceptor(options)
  ));

  return dio;
}
  
 dynamic requestInterceptor(RequestOptions options) async{
 if (options.headers.containsKey('auth')) {
   var token = await Auth().getToken();

    options.headers.addAll({ 'Authorizacion': 'Bearer $token'})
   }
 }