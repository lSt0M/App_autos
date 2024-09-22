import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  static const List<String> loggedBasePaths = [
    Routes.PROFILE,
    Routes.HOME,
    Routes.CARS,
    Routes.PARKINGS,
    Routes.ACCOUNTS,
    Routes.RESERVATION_DETAIL,
    Routes.SCAN_QR,
    Routes.PAYMENT,
  ];
  static const List<String> unloggedPaths = [
    Routes.ONBOARDING,
    Routes.LOGIN,
    Routes.REGISTER,
  ];

  bool containLoggedPath(String route) {
    return loggedBasePaths.any((lbp) => route.startsWith(lbp));
  }

  bool containUnloggedPath(String route) {
    return unloggedPaths.any((lup) => route.startsWith(lup));
  }

  @override
  RouteSettings? redirect(String? route) {
    bool isAuthenticated = UserService().checkAuthenticated();

    if (isAuthenticated && containLoggedPath(route!)) {
      return null;
    }

    if (!isAuthenticated && containUnloggedPath(route!)) {
      return null;
    }

    if (isAuthenticated) {
      return const RouteSettings(name: Routes.HOME);
    }

    return const RouteSettings(name: Routes.LOGIN);
  }
}
