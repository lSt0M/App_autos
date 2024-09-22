import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  // final UserService _userService = Get.find();
  final RxInt currentPage = 0.obs;
  final PageController pageController = PageController();
  List<OnboardingContents> contents = [
    OnboardingContents(
      title: "Bienvenido",
      image: "assets/images/onboarding-1.png",
      desc:
          "Descubre la forma más fácil y segura de estacionar tu vehículo. Reserva, paga y gestiona tu estacionamiento con solo unos toques.",
    ),
    OnboardingContents(
      title: "Reservas Anticipadas",
      image: "assets/images/onboarding-2.png",
      desc: "Planifica tu estacionamiento con antelación. Selecciona fecha, hora y establecimiento en segundos.",
    ),
    OnboardingContents(
      title: "Pago y Gestión de Vehículos",
      image: "assets/images/onboarding-3.png",
      desc: "Paga de manera segura y gestiona tus vehículos registrados fácilmente. Sin complicaciones, solo conveniencia.",
    ),
  ];

  @override
  void onReady() {
    super.onReady();
  }
}

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}
