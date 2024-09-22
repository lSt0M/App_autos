// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:valet_parking_app/modules/accounts/accounts_binding.dart';
import 'package:valet_parking_app/modules/accounts/accounts_view.dart';
import 'package:valet_parking_app/modules/cars/cars_binding.dart';
import 'package:valet_parking_app/modules/cars/cars_view.dart';
import 'package:valet_parking_app/modules/home/home_binfing.dart';
import 'package:valet_parking_app/modules/home/home_view.dart';
import 'package:valet_parking_app/modules/login/login_binding.dart';
import 'package:valet_parking_app/modules/login/login_view.dart';
import 'package:valet_parking_app/modules/onboarding/onboarding_binding.dart';
import 'package:valet_parking_app/modules/onboarding/onboarding_view.dart';
import 'package:valet_parking_app/modules/parkings/parking_binding.dart';
import 'package:valet_parking_app/modules/parkings/parking_view.dart';
import 'package:valet_parking_app/modules/payment/payment_binding.dart';
import 'package:valet_parking_app/modules/payment/payment_view.dart';
import 'package:valet_parking_app/modules/profile/profile_binding.dart';
import 'package:valet_parking_app/modules/profile/profile_view.dart';
import 'package:valet_parking_app/modules/register/register_binding.dart';
import 'package:valet_parking_app/modules/register/register_view.dart';
import 'package:valet_parking_app/modules/reservation_detail/reservation_detail_binding.dart';
import 'package:valet_parking_app/modules/reservation_detail/reservation_detail_view.dart';
import 'package:valet_parking_app/modules/scanqr/scanqr_binding.dart';
import 'package:valet_parking_app/modules/scanqr/scanqr_view.dart';
import 'package:valet_parking_app/routes/middlewares/auth_middleware.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.CARS,
      page: () => CarsView(),
      binding: CarsBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.ACCOUNTS,
      page: () => AccountsView(),
      binding: AccountsBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.PARKINGS,
      page: () => const ParkingsView(),
      binding: ParkingsBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.RESERVATION_DETAIL,
      page: () => ReservationDetailView(),
      binding: ReservationDetailBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.SCAN_QR,
      page: () => ScanQRView(),
      binding: ScanQRBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
  ];
}
