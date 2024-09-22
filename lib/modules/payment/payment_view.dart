import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/modules/payment/payment_controller.dart';
import 'package:valet_parking_app/routes/app_pages.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Regresar'),
        backgroundColor: Constants.BACKGROUND_COLOR,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final Uri uri = Uri.parse(Get.arguments);
            final String? id = uri.queryParameters['id'];
            Get.offAllNamed(
              Routes.RESERVATION_DETAIL,
              arguments: id,
            );
          },
        ),
      ),
      backgroundColor: Constants.BACKGROUND_COLOR,
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: WebViewWidget(
            controller: controller.webviewController,
          ),
        ),
      ),
    );
  }
}
