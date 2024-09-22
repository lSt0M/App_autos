import 'package:get/get.dart';
import 'package:valet_parking_app/modules/payment/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PaymentController>(PaymentController());
  }
}
