import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_sanctum/providers/auth.dart';

Dio dio() {
  var dio = Dio(BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/api/',
      responseType: ResponseType.plain,
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json',
      }));
  return dio;
}
