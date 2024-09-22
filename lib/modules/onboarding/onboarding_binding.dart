import 'package:get/get.dart';
import 'package:valet_parking_app/modules/onboarding/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnboardingController>(OnboardingController());
  }
}
