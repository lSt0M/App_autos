import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/storage/user_storage.dart';
// import 'package:valet_parking_app/data/services/user_service.dart';

class RepositoryConstants {
  static final RepositoryConstants _instance = RepositoryConstants._internal();
  factory RepositoryConstants() => _instance;
  RepositoryConstants._internal();
  final UserStorage _storage = UserStorage();
  final dio = Dio();

  final String _url = Constants.BASE_URL;

  Future<dynamic> sendPost(
    String path,
    Map<String, dynamic> body, {
    bool isAuth = true,
  }) async {
    final header = <String, String>{
      "Accept": "application/json",
      "content-type": "application/json",
    };
    if (isAuth) {
      header['Authorization'] = await _storage.getAccessToken();
    }

    final response = await dio.post(
      _url + path,
      data: jsonEncode(body),
      options: Options(
        headers: header,
        followRedirects: true,
        validateStatus: (status) => true,
      ),
    );

    if (![200, 201].contains(response.statusCode)) {
      showSnackBarError(response.data['errors'].cast<String>());
    }

    return response;
  }

  Future<dynamic> sendGet(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool isAuth = true,
  }) async {
    final header = <String, String>{
      "Accept": "application/json",
      "content-type": "application/json",
    };
    if (isAuth) {
      header['Authorization'] = await _storage.getAccessToken();
    }
    final response = await dio.get(
      _url + path,
      options: Options(
        headers: header,
        followRedirects: true,
        validateStatus: (status) => true,
      ),
    );

    if (![200, 201].contains(response.statusCode)) {
      showSnackBarError(response.data['errors'].cast<String>());
    }

    return response;
  }

  Future<dynamic> sendPut(
    String path,
    Map<String, dynamic> body, {
    bool isAuth = true,
  }) async {
    final header = <String, String>{
      "Accept": "application/json",
      "content-type": "application/json",
    };
    if (isAuth) {
      header['Authorization'] = await _storage.getAccessToken();
    }

    final response = await dio.put(
      _url + path,
      data: jsonEncode(body),
      options: Options(
        headers: header,
        followRedirects: true,
        validateStatus: (status) => true,
      ),
    );

    if (![200, 201].contains(response.statusCode)) {
      showSnackBarError(response.data['errors'].cast<String>());
    }

    return response;
  }

  Future<dynamic> sendDelete(
    String path, {
    bool isAuth = true,
  }) async {
    final header = <String, String>{
      "Accept": "application/json",
      "content-type": "application/json",
    };
    if (isAuth) {
      header['Authorization'] = await _storage.getAccessToken();
    }

    final response = await dio.delete(
      _url + path,
      options: Options(
        headers: header,
        followRedirects: true,
        validateStatus: (status) => true,
      ),
    );

    if (![200, 201].contains(response.statusCode)) {
      showSnackBarError(response.data['errors'].cast<String>());
    }

    return response;
  }

  showSnackBarError(List<String> message) {
    Get.snackbar(
      'Error',
      message.join('\n'),
      backgroundColor: Colors.red[800],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
    );
  }
}
