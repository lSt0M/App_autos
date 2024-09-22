import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/components/custom_button.dart';
import 'package:valet_parking_app/components/custom_navigation_bar.dart';
import 'package:valet_parking_app/components/custom_text_field.dart';
import 'package:valet_parking_app/components/custom_title.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/modules/accounts/accounts_controller.dart';

class AccountsView extends GetView<AccountsController> {
  AccountsView({super.key});

  final UserService userService = UserService();

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
                const CustomTitle(title: 'Registrar cuenta de trabajador'),
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(currentIndex: 1),
    );
  }
}
