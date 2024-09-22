import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/components/color_picker_dialog.dart';
import 'package:valet_parking_app/components/custom_add_button.dart';
import 'package:valet_parking_app/components/custom_car_card.dart';
import 'package:valet_parking_app/components/custom_dropdown_button.dart';
import 'package:valet_parking_app/components/custom_navigation_bar.dart';
import 'package:valet_parking_app/components/custom_text_button.dart';
import 'package:valet_parking_app/components/custom_text_field.dart';
import 'package:valet_parking_app/components/custom_title.dart';
import 'package:valet_parking_app/constants/brand_cars.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/models/car_model.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/modules/cars/cars_controller.dart';

class CarsView extends GetView<CarsController> {
  CarsView({super.key});

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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTitle(title: 'Autos guardados'),
                    CustomAddButton(
                      onPressed: () {
                        openCreateBottomSheet();
                      },
                    ),
                  ],
                ),
                Obx(
                  () => controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Constants.FOCUSED_COLOR), // Change the color here
                        )
                      : controller.cars.isEmpty
                          ? const Center(
                              child: Text(
                                'No tienes autos guardados',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Constants.FOCUSED_COLOR,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 20),
                              shrinkWrap: true,
                              itemCount: controller.cars.length,
                              itemBuilder: (context, index) {
                                return CarCard(
                                  car: controller.cars[index],
                                  onEditPressed: () {
                                    openEditBottomSheet(controller.cars[index]);
                                  },
                                  onDeletePressed: () {
                                    controller.deleteCar(controller.cars[index].id!);
                                  },
                                );
                              },
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

  void openCreateBottomSheet() {
    controller.startCreatingCar();
    Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextButton(
                  text: 'Cancelar',
                  onPressed: Get.back,
                  textColor: Constants.FOCUSED_COLOR,
                ),
                Obx(
                  () => CustomTextButton(
                    text: 'Añadir',
                    onPressed: () {
                      Get.back();
                      controller.createCar();
                    },
                    isEnabled: controller.isButtonEnabled.value,
                    textColor: Constants.FOCUSED_COLOR,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 25, left: 25, right: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => CustomDropDownButton(
                      prefixIcon: Icons.car_repair,
                      hint: 'Seleccionar marca',
                      items: carBrandList,
                      selectedItem: controller.newCar['brand'],
                      onChanged: (value) {
                        controller.onChangeForm('brand', value);
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => CustomTextField(
                      hintText: "Placa del auto",
                      prefixIcon: Icons.card_membership,
                      onChanged: (value) => controller.onChangeForm('carPlate', value),
                      initialValue: controller.newCar['carPlate'],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => CustomTextField(
                      hintText: "Modelo",
                      prefixIcon: Icons.mode_edit_outline,
                      onChanged: (value) => controller.onChangeForm('model', value),
                      initialValue: controller.newCar['model'],
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buttonColor(true),
                ],
              ),
            ),
          ],
        ),
      ),
      persistent: false,
      backgroundColor: Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  void openEditBottomSheet(CarModel car) {
    controller.startEditingCar(car);
    Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextButton(
                  text: 'Cancelar',
                  onPressed: Get.back,
                  textColor: Constants.FOCUSED_COLOR,
                ),
                CustomTextButton(
                  text: 'Editar',
                  onPressed: () {
                    Get.back();
                    controller.editCar();
                  },
                  textColor: Constants.FOCUSED_COLOR,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 25, left: 25, right: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      controller.editingCar['carPlate'],
                      style: const TextStyle(
                        color: Constants.FOCUSED_COLOR,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text("Placa del auto"),
                    trailing: const Icon(
                      Icons.card_membership,
                      size: 35,
                      color: Constants.FOCUSED_COLOR,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    title: Text(
                      controller.editingCar['brand'],
                      style: const TextStyle(
                        color: Constants.FOCUSED_COLOR,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text("Marca del auto"),
                    trailing: const Icon(
                      Icons.edit,
                      size: 35,
                      color: Constants.FOCUSED_COLOR,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    title: Text(
                      controller.editingCar['model'],
                      style: const TextStyle(
                        color: Constants.FOCUSED_COLOR,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text("Modelo del auto"),
                    trailing: const Icon(
                      Icons.car_repair_rounded,
                      size: 35,
                      color: Constants.FOCUSED_COLOR,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buttonColor(false),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  Widget _buttonColor(bool isCreateCar) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Seleccionar color:',
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Constants.FOCUSED_COLOR),
        ),
        const SizedBox(width: 10),
        Obx(
          () => SizedBox(
            width: 60,
            height: 60,
            child: OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(controller.pickedColor.value),
                side: MaterialStateProperty.all(const BorderSide(color: Colors.black, width: 8)), //
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Bordes cuadrados
                  ),
                ),
              ),
              onPressed: () {
                if (isCreateCar) {
                  colorPickerDialog(
                    controller.pickedColor.value,
                    controller.onChangeColor,
                  );
                } else {
                  colorPickerDialog(
                    controller.pickedColor.value,
                    controller.onChangeEditColor,
                  );
                }
              },
              child: const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }
}
