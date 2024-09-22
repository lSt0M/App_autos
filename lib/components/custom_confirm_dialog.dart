// mostrar dialogo de confirmacion con getx
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showConfirmDialog({required String content, required void Function() onConfirm}) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('Confirmar'),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Get.back();
          },
          child: const Text('Sí'),
        ),
      ],
    ),
  );
}
