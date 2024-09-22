import 'package:get/get.dart';
import 'package:valet_parking_app/modules/create_parking/create_parking_controller.dart';

class CreateParkingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateParkingController>(CreateParkingController());
  }
}
