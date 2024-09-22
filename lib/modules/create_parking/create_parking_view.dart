import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/modules/cars/cars_controller.dart';

class CreatingParkingView extends GetView<CarsController> {
  CreatingParkingView({super.key});

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
              mainAxisSize: MainAxisSize.max,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
