import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({super.key, required this.currentIndex});

  final int currentIndex;

  final UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTapByRole(userService.getRole(), index),
      selectedItemColor: Constants.FOCUSED_COLOR,
      items: _getItemsByRole(userService.getRole()),
    );
  }

  void _onTapByRole(String role, int index) {
    switch (role) {
      case 'USER_ROLE':
        switch (index) {
          case 0:
            Get.offAllNamed(Routes.HOME);
            break;
          case 1:
            Get.offAllNamed(Routes.CARS);
            break;
          case 2:
            Get.offAllNamed(Routes.PROFILE);
            break;
        }
        break;
      case 'EMPLOYEE_ROLE':
        switch (index) {
          case 0:
            Get.offAllNamed(Routes.HOME);
            break;
          case 1:
            Get.offAllNamed(Routes.PARKINGS);
            break;
          case 2:
            Get.offAllNamed(Routes.PROFILE);
            break;
        }
        break;
      case 'ADMIN_ROLE':
        switch (index) {
          case 0:
            Get.offAllNamed(Routes.HOME);
            break;
          case 1:
            Get.offAllNamed(Routes.ACCOUNTS);
            break;
          case 2:
            Get.offAllNamed(Routes.PROFILE);
            break;
        }
        break;
      default:
        switch (index) {
          case 0:
            Get.offAllNamed(Routes.HOME);
            break;
          case 1:
            Get.offAllNamed(Routes.CARS);
            break;
          case 2:
            Get.offAllNamed(Routes.PROFILE);
            break;
        }
        break;
    }
  }

  List<BottomNavigationBarItem> _getItemsByRole(String role) {
    switch (role) {
      case 'USER_ROLE':
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: 'Autos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ];
      case 'EMPLOYEE_ROLE':
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check_rounded),
            label: 'Estacionamientos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          )
        ];
      case 'ADMIN_ROLE':
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cuenta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ];
      default:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: 'Autos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ];
    }
  }
}
