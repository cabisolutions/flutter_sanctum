import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_sanctum/models/user.dart';
import 'package:flutter_sanctum/widgets/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;

  final storage = FlutterSecureStorage();

  late User _user;
  User get user => _user;

  bool get authenticated => _authenticated;

  Future login({Map? credentials}) async {
    //_authenticated = true;
    String deviceID = await getDeviceID();

    Dio.Response response = await dio().post('auth/token',
        data: json.encode(credentials!..addAll({'deviceID': deviceID})));
    String token = json.decode(response.toString())['token'];
    log(token);

    await attempt(token);
    storeToke(token);
  }

  Future attempt(String token) async {
    try {
      Dio.Response response = await dio().get(
        'auth/user',
        options: Dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      _user = User.fromJson(json.decode(response.toString()));
      _authenticated = true;
    } catch (e) {
      _authenticated = false;
    }

    notifyListeners();
  }

  storeToke(String token) async {
    await storage.write(key: 'auth', value: token);
  }

  Future getDeviceID() async {
    String? deviceID;
    try {
      deviceID = await PlatformDeviceId.getDeviceId;
      print('Device ID: $deviceID');
    } catch (e) {}

    return deviceID;
  }

  void logout() {
    _authenticated = false;

    notifyListeners();
  }
}
