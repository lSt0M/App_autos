import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/components/custom_subtitle.dart';
import 'package:valet_parking_app/components/custom_text_button.dart';
import 'package:valet_parking_app/components/custom_text_field.dart';
import 'package:valet_parking_app/components/custom_title.dart';
import 'package:valet_parking_app/components/custom_button.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/modules/login/login_controller.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Stack(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/login.png',
                      height: 300,
                    ),
                    const CustomTitle(
                      title: '¡Bienvenido de nuevo!',
                    ),
                    const SizedBox(height: 15),
                    const CustomSubtitle(
                      subtitle:
                          'Accede a tu cuenta para disfrutar de todos los beneficios de Elite App. ¿Listo para estacionar sin complicaciones?',
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                        hintText: 'Correo',
                        prefixIcon: Icons.email,
                        onChanged: (value) => controller.onChangeForm('email', value)),
                    const SizedBox(height: 20),
                    Obx(
                      () => CustomTextField(
                        hintText: 'Contraseña',
                        obscureText: !controller.isPasswordVisible.value,
                        isPassword: true,
                        onSuffixPressed: controller.isPasswordVisible.toggle,
                        prefixIcon: Icons.lock,
                        onChanged: (value) => controller.onChangeForm('password', value),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => CustomButton(
                        isEnabled: controller.isButtonEnabled.value,
                        isLoading: controller.isLoading.value,
                        text: 'Iniciar sesión',
                        onPressed: controller.login,
                      ),
                    ),
                    CustomTextButton(
                      text: 'Registrarse',
                      onPressed: () {
                        Get.offAllNamed(Routes.REGISTER);
                      },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    splashRadius: 1,
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Get.offAllNamed(Routes.ONBOARDING);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Constants.PRIMARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
