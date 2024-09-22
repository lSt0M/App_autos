import 'package:get/get.dart';
import 'package:valet_parking_app/modules/reservation_detail/reservation_detail_controller.dart';

class ReservationDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ReservationDetailController>(ReservationDetailController());
  }
}
