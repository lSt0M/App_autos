import 'package:get/get.dart';
import 'package:valet_parking_app/modules/accounts/accounts_controller.dart';

class AccountsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AccountsController>(AccountsController());
  }
}
