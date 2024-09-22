import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/components/custom_text_button.dart';
import 'package:valet_parking_app/constants/constants.dart';

Future colorPickerDialog(Color pickedColor, void Function(Color) onChangeColor) async {
  Color currentColor = pickedColor;
  Get.dialog(
    AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'Seleccione el color de su auto',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Constants.FOCUSED_COLOR,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: Get.size.width - 20,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              HueRingPicker(
                pickerColor: currentColor,
                onColorChanged: (color) => currentColor = color,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextButton(
                    text: 'Cancelar',
                    textColor: Constants.FOCUSED_COLOR,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  CustomTextButton(
                    text: 'Seleccionar',
                    textColor: Constants.FOCUSED_COLOR,
                    onPressed: () {
                      onChangeColor(currentColor);
                      Get.back();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
