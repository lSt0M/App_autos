import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/modules/scanqr/scanqr_controller.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class ScanQRView extends GetView<ScanQRController> {
  const ScanQRView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Regresar'),
        backgroundColor: Constants.BACKGROUND_COLOR,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed(
              Routes.HOME,
            );
          },
        ),
      ),
      backgroundColor: Constants.BACKGROUND_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Constants.FOCUSED_COLOR), // Change the color here
                        ),
                      )
                    : QRView(
                        key: controller.qrKey,
                        onQRViewCreated: controller.onQRViewCreated,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
