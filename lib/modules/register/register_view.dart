import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/components/custom_subtitle.dart';
import 'package:valet_parking_app/components/custom_text_button.dart';
import 'package:valet_parking_app/components/custom_text_field.dart';
import 'package:valet_parking_app/components/custom_title.dart';
import 'package:valet_parking_app/components/custom_button.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/modules/register/register_controller.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              children: [
                const CustomTitle(
                  title: 'Únete a Elite App',
                ),
                const SizedBox(height: 15),
                const CustomSubtitle(
                  subtitle:
                      'Crea tu cuenta para comenzar a reservar, pagar y gestionar tu estacionamiento de manera rápida y segura. ¡Es gratis y solo te tomará unos segundos!',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Nombre Completo',
                  prefixIcon: Icons.person,
                  onChanged: (value) => controller.onChangeForm('name', value),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Correo',
                  prefixIcon: Icons.email,
                  onChanged: (value) => controller.onChangeForm('email', value),
                ),
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
                  () => CustomTextField(
                    hintText: 'Repetir Contraseña',
                    obscureText: !controller.isPasswordConfirmationVisible.value,
                    isPassword: true,
                    onSuffixPressed: controller.isPasswordConfirmationVisible.toggle,
                    prefixIcon: Icons.lock,
                    onChanged: (value) => controller.onChangeForm('passwordConfirmation', value),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                    hintText: 'DNI',
                    prefixIcon: Icons.credit_card_sharp,
                    onChanged: (value) => controller.onChangeForm('dni', value)),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Número de Teléfono',
                  prefixIcon: Icons.phone,
                  onChanged: (value) => controller.onChangeForm('phone', value),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => CustomButton(
                    text: 'Registrarse',
                    isEnabled: controller.isButtonEnabled.value,
                    onPressed: controller.register,
                    isLoading: controller.isLoading.value,
                  ),
                ),
                CustomTextButton(
                  text: 'Iniciar Sesión',
                  onPressed: () {
                    Get.offNamed(Routes.LOGIN);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
