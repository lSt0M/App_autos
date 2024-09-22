import 'package:get/get.dart';
import 'package:valet_parking_app/modules/scanqr/scanqr_controller.dart';

class ScanQRBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ScanQRController>(ScanQRController());
  }
}
