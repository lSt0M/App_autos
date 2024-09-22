import 'package:get/get.dart';
import 'package:valet_parking_app/modules/parkings/parking_controller.dart';

class ParkingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ParkingsController>(ParkingsController());
  }
}
