import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/components/custom_navigation_bar.dart';
import 'package:valet_parking_app/components/custom_subtitle.dart';
import 'package:valet_parking_app/components/custom_button.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/modules/cars/cars_controller.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class ProfileView extends GetView<CarsController> {
  ProfileView({super.key});

  final UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Constants.FOCUSED_COLOR,
                  radius: 70,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 110,
                  ),
                ),
                const SizedBox(height: 10),
                CustomSubtitle(subtitle: userService.user.value!.name),
                const SizedBox(height: 20),
                ListView(
                  shrinkWrap: true,
                  children: [
                    _customCard('Correo Electrónico', userService.user.value!.email, Icons.email),
                    _customCard('Teléfono', userService.user.value!.phone, Icons.phone),
                    _customCard('DNI', userService.user.value!.dni, Icons.credit_card),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  color: Colors.redAccent,
                  text: 'Cerrar Sesión',
                  onPressed: () async {
                    await userService.logout();
                    Get.offAllNamed(Routes.LOGIN);
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(currentIndex: 2),
    );
  }

  Widget _customCard(String title, String value, IconData icon) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: Icon(
          icon,
          color: Constants.FOCUSED_COLOR,
          size: 30,
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
