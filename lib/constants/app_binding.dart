import 'package:get/get.dart';
import 'package:valet_parking_app/data/services/user_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserService());
  }
}
