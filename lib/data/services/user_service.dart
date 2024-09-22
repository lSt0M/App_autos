import 'dart:convert';

import 'package:get/get.dart';
import 'package:valet_parking_app/data/models/user_model.dart';
import 'package:valet_parking_app/data/repository/user_repository.dart';
import 'package:valet_parking_app/data/storage/user_storage.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();
  Rx<User?> user = Rx<User?>(null);

  final UserRepository _userRepository = UserRepository();
  final UserStorage _storage = UserStorage();

  initSession() async {
    final user = await _storage.getUser();
    if (user != null) {
      this.user.value = user;
    }
  }

  bool checkAuthenticated() {
    return user.value != null;
  }

  Future<void> logout() async {
    await _storage.removeUser();
    user.value = null;
  }

  Future<bool> login(String email, String password) async {
    final result = await _userRepository.loginCredentials(email, password);
    if (result != null) {
      _storage.saveUser(result);
      user.value = result;
      return true;
    }
    return false;
  }

  Future<bool> register(User user, bool isAdmin) async {
    final result = await _userRepository.createUser(user, isAdmin);
    if (result != null) {
      if (!isAdmin) {
        _storage.saveUser(result);
        this.user.value = result;
      }
      return true;
    }
    return false;
  }

  String getRole() {
    final token = user.value!.token!;
    final result = _parseJwt(token);
    return result['role'];
  }

  Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = jsonDecode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  // Future<void> updateUser(User user) async {
  //   final result = await _userRepository.updateUser(user);
  //   if (result != null) {
  //     _storage.saveUser(result);
  //     this.user.value = result;
  //   }
  // }

  // Future<void> refreshUserDetails() async {
  //   if (isRefreshing) return;
  //   isRefreshing = true;
  //   final result = await _userRepository.getUserDetails();
  //   if (result != null && (result.toString() != user.value.toString())) {
  //     _storage.saveUser(result);
  //     user.value = result;
  //   }
  //   isRefreshing = false;
  // }
}
