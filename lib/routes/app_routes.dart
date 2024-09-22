// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const ONBOARDING = _Paths.ONBOARDING;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const HOME = _Paths.HOME;
  static const CARS = _Paths.CARS;
  static const PROFILE = _Paths.PROFILE;
  static const PARKINGS = _Paths.PARKINGS;
  static const ACCOUNTS = _Paths.ACCOUNTS;
  static const RESERVATION_DETAIL = _Paths.RESERVATION_DETAIL;
  static const SCAN_QR = _Paths.SCAN_QR;
  static const PAYMENT = _Paths.PAYMENT;
}

abstract class _Paths {
  _Paths._();
  static const ONBOARDING = '/onboarding';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const HOME = '/home';
  static const CARS = '/cars';
  static const PROFILE = '/profile';
  static const PARKINGS = '/parkings';
  static const ACCOUNTS = '/accounts';
  static const RESERVATION_DETAIL = '/reservation-detail';
  static const SCAN_QR = '/scan-qr';
  static const PAYMENT = '/payment';
}
