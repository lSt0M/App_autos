import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_share/social_share.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:valet_parking_app/components/custom_confirm_dialog.dart';
import 'package:valet_parking_app/components/custom_subtitle.dart';
import 'package:valet_parking_app/components/custom_button.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/data/utils/date_formatter.dart';
import 'package:valet_parking_app/data/utils/state_formatter.dart';
import 'package:valet_parking_app/modules/reservation_detail/reservation_detail_controller.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

import 'dart:ui' as ui;

class ReservationDetailView extends GetView<ReservationDetailController> {
  ReservationDetailView({super.key});

  final UserService userService = UserService();
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Constants.PRIMARY_COLOR,
          ),
          onPressed: () => Get.offAllNamed(Routes.HOME),
        ),
        title: const Text(
          'Detalle de la reserva',
          style: TextStyle(
            color: Constants.PRIMARY_COLOR,
          ),
        ),
        centerTitle: true,
        backgroundColor: Constants.BACKGROUND_COLOR,
        elevation: 0,
      ),
      backgroundColor: Constants.BACKGROUND_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Constants.FOCUSED_COLOR), // Change the color here
                          ),
                        )
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.reservation.value != null &&
                          controller.reservation.value?.currentState == 'CREATED' &&
                          userService.getRole() == 'USER_ROLE'
                      ? Column(
                          children: [
                            const CustomSubtitle(subtitle: 'Muestre el código QR'),
                            SizedBox(
                              height: Get.width * 0.75,
                              child: RepaintBoundary(
                                key: _globalKey,
                                child: Container(
                                  color: Colors.white,
                                  child: SfBarcodeGenerator(
                                    value: controller.reservation.value!.id!,
                                    symbology: QRCode(),
                                    showValue: false,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              text: 'Compartir código QR',
                              onPressed: () async {
                                _shareQRCode();
                              },
                              color: const Color(0xFF263238),
                            ),
                            const SizedBox(height: 15),
                          ],
                        )
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.reservation.value != null
                      ? _cardDetail(
                          title: controller.reservation.value!.car.carPlate,
                          subtitle1: 'Marca: ${controller.reservation.value!.car.brand}',
                          subtitle2: 'Modelo: ${controller.reservation.value!.car.model}',
                          icon: Icon(
                            Icons.directions_car_filled_rounded,
                            size: 60,
                            color: Color(
                              int.parse('0x${controller.reservation.value!.car.color}'),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.reservation.value != null
                      ? _cardDetail(
                          title: controller.reservation.value!.parkingLot.address,
                          subtitle1: 'Capacidad máxima: ${controller.reservation.value!.parkingLot.maxCapacity.toString()}',
                          subtitle2: 'Espacios ocupados: ${controller.reservation.value!.parkingLot.occupiedSpaces.toString()}',
                          icon: const Icon(
                            Icons.local_parking,
                            size: 60,
                            color: Constants.WHITE_COLOR,
                          ),
                        )
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.reservation.value != null
                      ? _cardDetail(
                          title: stateToString(controller.reservation.value!.currentState),
                          subtitle1: 'Fecha de reserva: ${showOnlyDate(controller.reservation.value!.startTime)}',
                          subtitle2: 'Hora de reserva: ${showOnlyTime(controller.reservation.value!.startTime)}',
                          icon: const Icon(
                            Icons.bookmark,
                            size: 60,
                            color: Constants.WHITE_COLOR,
                          ),
                        )
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.reservation.value != null &&
                          (controller.reservation.value!.currentState == 'PAID' ||
                              controller.reservation.value!.currentState == 'RETURNED')
                      ? _cardDetail(
                          title: 'Total pagado: S/.${controller.reservation.value!.totalCost}',
                          subtitle1: 'Inicio: ${dateToDisplayFromBackend(controller.reservation.value!.startTime)}',
                          subtitle2: 'Fin: ${dateToDisplayFromBackend(controller.reservation.value!.endTime!)}',
                          icon: const Icon(
                            Icons.attach_money,
                            size: 60,
                            color: Constants.WHITE_COLOR,
                          ),
                        )
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.restTime.value != null &&
                          controller.reservation.value!.currentState == 'RECEIVED' &&
                          userService.getRole() == 'USER_ROLE'
                      ? Column(
                          children: [
                            Card(
                              elevation: 5,
                              margin: const EdgeInsets.only(bottom: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              color: const Color(0xFF263238),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                                child: Center(
                                  child: Text.rich(
                                    style: const TextStyle(color: Colors.white),
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Realice el pago antes de ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        TextSpan(
                                          text: '${controller.restTime.value!.inSeconds}',
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(
                                          text: ' segundos o el monto ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        TextSpan(
                                          text: 'S/.${controller.reservation.value!.totalCost!}',
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(
                                          text: ' se actualizará.',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CustomButton(
                              text: 'Pagar',
                              onPressed: () {
                                Get.offAllNamed(
                                  Routes.PAYMENT,
                                  arguments: controller.getPaymentUrl(),
                                );
                              },
                              color: const Color(0xFF263238),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.restTime.value != null &&
                          controller.reservation.value!.currentState == 'RECEIVED' &&
                          userService.getRole() == 'EMPLOYEE_ROLE'
                      ? Column(
                          children: [
                            Card(
                              elevation: 5,
                              margin: const EdgeInsets.only(bottom: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              color: const Color(0xFF263238),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                                child: Center(
                                  child: Text.rich(
                                    style: const TextStyle(color: Colors.white),
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'El monto total es de ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        TextSpan(
                                          text: 'S/.${controller.reservation.value!.totalCost!}',
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(
                                          text: ' el monto total se actualizará en ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        TextSpan(
                                          text: '${controller.restTime.value!.inSeconds}',
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(
                                          text: '.',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CustomButton(
                              text: 'Confirmar pago en efectivo',
                              onPressed: () {
                                showConfirmDialog(
                                  content: '¿Está seguro que desea confirmar el pago en efectivo?',
                                  onConfirm: () {
                                    controller.setCashPayment();
                                  },
                                );
                              },
                              color: const Color(0xFF263238),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.reservation.value != null && controller.reservation.value!.currentState == 'PAID'
                      ? CustomButton(
                          text: 'Confirmar devolución del vehículo',
                          onPressed: () {
                            showConfirmDialog(
                              content: '¿Está seguro que el vehículo ha sido devuelto?',
                              onConfirm: () {
                                controller.setReturned();
                              },
                            );
                          },
                          color: const Color(0xFF263238),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardDetail({
    required String title,
    required String subtitle1,
    required String subtitle2,
    required Icon icon,
  }) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: const Color(0xFF263238), // Color de fondo del Card
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              subtitle1,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              subtitle2,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _shareQRCode() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;

        File imgFile = File('$tempPath/qr_code.png');
        await imgFile.writeAsBytes(pngBytes);
        SocialShare.shareOptions('Te comparto el código QR de mi reserva.', imagePath: imgFile.path);
      }
    } catch (e) {
      // print('Error: $e');
    }
  }
}
