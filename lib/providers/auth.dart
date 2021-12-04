import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_sanctum/widgets/dio.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;

  bool get authenticated => _authenticated;

  Future login({Map? credentials}) async {
    _authenticated = true;
    Dio.Response response =
        await dio().post('auth/token', data: json.encode(credentials));
    String token = json.decode(response.toString())['token'];
    log(token);
    notifyListeners();
  }

  void logout() {
    _authenticated = false;

    notifyListeners();
  }
}
