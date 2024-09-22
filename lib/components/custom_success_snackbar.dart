import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBarSuccess(String message) {
  Get.snackbar(
    'Éxito',
    message,
    backgroundColor: Colors.green[800],
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
  );
}
