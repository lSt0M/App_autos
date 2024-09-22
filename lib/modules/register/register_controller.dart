import 'package:get/get.dart';
import 'package:valet_parking_app/data/models/user_model.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final UserService _userService = UserService();
  RxBool isPasswordVisible = RxBool(false);
  RxBool isPasswordConfirmationVisible = RxBool(false);
  RxBool isButtonEnabled = RxBool(false);
  RxBool isLoading = RxBool(false);

  RxMap<String, String> userForm = RxMap<String, String>({
    'name': '',
    'email': '',
    'password': '',
    'dni': '',
    'phone': '',
    'passwordConfirmation': '',
  });

  void onChangeForm(String key, String value) {
    userForm[key] = value;
    isButtonEnabled.value = userForm['name'] != '' &&
        userForm['email'] != '' &&
        userForm['password'] != '' &&
        userForm['dni'] != '' &&
        userForm['phone'] != '' &&
        userForm['password'] == userForm['passwordConfirmation'];
    isButtonEnabled.refresh();
  }

  void register() async {
    isLoading.value = true;
    final isRegistered = await _userService.register(User.fromJson(userForm), false);
    isLoading.value = false;
    if (isRegistered) {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }
}
