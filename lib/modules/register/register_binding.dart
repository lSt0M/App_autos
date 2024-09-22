import 'package:get/get.dart';
import 'package:valet_parking_app/modules/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController());
  }
}
