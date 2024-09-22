import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class LoginController extends GetxController {
  final UserService _userService = UserService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isPasswordVisible = RxBool(false);
  RxBool isButtonEnabled = RxBool(false);
  RxBool isLoading = RxBool(false);

  RxMap<String, String> userForm = RxMap<String, String>({
    'email': '',
    'password': '',
  });

  void onChangeForm(String key, String value) {
    userForm[key] = value;
    isButtonEnabled.value = userForm['email'] != '' && userForm['password'] != '';
    isButtonEnabled.refresh();
  }

  void login() async {
    isLoading.value = true;
    final isLogged = await _userService.login(userForm['email']!, userForm['password']!);
    isLoading.value = false;
    if (isLogged) {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }
}
