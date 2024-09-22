import 'package:get/get.dart';
import 'package:valet_parking_app/routes/app_pages.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentController extends GetxController {
  final WebViewController webviewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.contains('google.com')) {
            final Uri uri = Uri.parse(Get.arguments);
            final String? id = uri.queryParameters['id'];
            Get.offAllNamed(
              Routes.RESERVATION_DETAIL,
              arguments: id,
            );
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(Get.arguments));

  @override
  void onReady() async {
    super.onReady();
  }
}
