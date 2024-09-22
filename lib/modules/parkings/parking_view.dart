import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:valet_parking_app/components/custom_add_button.dart';
import 'package:valet_parking_app/components/custom_confirm_dialog.dart';
import 'package:valet_parking_app/components/custom_navigation_bar.dart';
import 'package:valet_parking_app/components/custom_parking_card.dart';
import 'package:valet_parking_app/components/custom_text_button.dart';
import 'package:valet_parking_app/components/custom_text_field.dart';
import 'package:valet_parking_app/components/custom_title.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/models/parkinglot_model.dart';
import 'package:valet_parking_app/modules/parkings/parking_controller.dart';

class ParkingsView extends GetView<ParkingsController> {
  const ParkingsView({super.key});

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
                    const CustomTitle(title: 'Estacionamientos\nguardados'),
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
                      : controller.parkings.isEmpty
                          ? const Center(
                              child: Text(
                                'No tienes estacionamientos guardados',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Constants.FOCUSED_COLOR,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 20),
                              shrinkWrap: true,
                              itemCount: controller.parkings.length,
                              itemBuilder: (context, index) {
                                return ParkingCard(
                                  parking: controller.parkings[index],
                                  onTap: () {
                                    openEditBottomSheet(controller.parkings[index]);
                                  },
                                  onDeletePressed: () {
                                    showConfirmDialog(
                                      content: '¿Estás seguro de que deseas eliminar este estacionamiento?',
                                      onConfirm: () {
                                        controller.deleteParking(controller.parkings[index].id!);
                                      },
                                    );
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
    controller.startCreatingParking();
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
                      controller.createParking();
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
                    () => CustomTextField(
                      hintText: "Dirección",
                      prefixIcon: Icons.location_on_outlined,
                      onChanged: (value) => controller.onChangeForm('address', value),
                      initialValue: controller.newParking['address'],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => CustomTextField(
                      hintText: "Capacidad máxima",
                      prefixIcon: Icons.mode_edit_outline,
                      onChanged: (value) => controller.onChangeForm('maxCapacity', value),
                      initialValue: controller.newParking['maxCapacity'],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // CustomTextButton(
                  //     text: 'Seleccionar dirección',
                  //     onPressed: () {
                  //       openMap(-12.1612718, -76.9758269);
                  //     }),
                  // const SizedBox(height: 15),
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

  void openEditBottomSheet(ParkingLotModel parking) {
    controller.startEditingParking(parking);
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
                    controller.editParking();
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
                  Obx(
                    () => ListTile(
                      title: Text(
                        controller.editingParking['address'],
                        style: const TextStyle(
                          color: Constants.FOCUSED_COLOR,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: const Text("Dirección del estacionamiento"),
                      trailing: const Icon(
                        Icons.location_pin,
                        size: 35,
                        color: Constants.FOCUSED_COLOR,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => ListTile(
                      title: Text(
                        controller.editingParking['occupiedSpaces'].toString(),
                        style: const TextStyle(
                          color: Constants.FOCUSED_COLOR,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: const Text("Espacios ocupados"),
                      trailing: const Icon(
                        Icons.car_repair_rounded,
                        size: 35,
                        color: Constants.FOCUSED_COLOR,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: "Capacidad máxima",
                    prefixIcon: Icons.reduce_capacity,
                    onChanged: (value) => controller.onChangeEdditingForm('maxCapacity', value),
                    initialValue: controller.editingParking['maxCapacity'].toString(),
                  ),
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

  static Future<void> openMap(double lat, double lng) async {
    Uri url = Uri.parse('geo:${lat},${lng}?q=${lat},${lng}');
    launchUrl(url);
  }
}
