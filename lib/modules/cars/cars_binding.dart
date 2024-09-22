import 'package:get/get.dart';
import 'package:valet_parking_app/modules/cars/cars_controller.dart';

class CarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CarsController>(CarsController());
  }
}
