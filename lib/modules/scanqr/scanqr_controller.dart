import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:valet_parking_app/components/custom_success_snackbar.dart';
import 'package:valet_parking_app/data/repository/reservation_repository.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class ScanQRController extends GetxController {
  final ReservationRepository _reservationRepository = ReservationRepository();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrcontroller;
  Rx<bool> isLoading = Rx(false);

  void onQRViewCreated(QRViewController ncontroller) {
    qrcontroller = ncontroller;
    ncontroller.scannedDataStream.listen((scanData) async {
      result = scanData;
      if (scanData.code?.isNotEmpty ?? false) {
        isLoading.value = true;
        final result = await _reservationRepository.toState(scanData.code!, 'RECEIVED');
        isLoading.value = false;
        Get.offAllNamed(Routes.HOME);
        if (result) {
          showSnackBarSuccess('El código QR a sido escaneado correctamente');
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }
}
