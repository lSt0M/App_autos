import 'dart:async';

import 'package:get/get.dart';
import 'package:valet_parking_app/components/custom_success_snackbar.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/models/reservation_model.dart';
import 'package:valet_parking_app/data/repository/reservation_repository.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/data/utils/date_formatter.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class ReservationDetailController extends GetxController {
  final UserService _userService = UserService();
  final ReservationRepository _reservationRepository = ReservationRepository();
  RxBool isPasswordVisible = RxBool(false);
  RxBool isPasswordConfirmationVisible = RxBool(false);
  RxBool isButtonEnabled = RxBool(false);
  RxBool isLoading = RxBool(false);
  Rx<ReservationModel?> reservation = Rx(null);
  Rx<Duration?> restTime = Rx(null);
  Timer? _timer;

  Future<void> getReservationById() async {
    isLoading.value = true;
    final isGone = await _reservationRepository.getReservationById(Get.arguments);
    if (isGone == null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      reservation.value = isGone;
      if (isGone.currentState == 'RECEIVED') {
        _startTimer(dateFromBackend(reservation.value!.startTime));
      }
      reservation.refresh();
    }
    isLoading.value = false;
  }

  void _startTimer(DateTime dateTime) async {
    DateTime ahora = getDateTimeNow();
    int diferenciaEnSegundos = ahora.difference(dateTime).inSeconds;
    int resto = diferenciaEnSegundos % 300;

    restTime.value = Duration(seconds: 300 - resto);
    restTime.refresh();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (restTime.value!.inSeconds > 0) {
        restTime.value = Duration(seconds: restTime.value!.inSeconds - 1);
        restTime.refresh();
      } else {
        _timer!.cancel();
        getReservationById();
      }
    });
  }

  String getPaymentUrl() {
    List<String> splittedName = _userService.user.value!.name.split(" ");
    final name = splittedName[0];
    final lastname = splittedName[1];
    final email = _userService.user.value!.email;
    final amount = reservation.value!.totalCost;
    final id = reservation.value!.id;
    final token = _userService.user.value!.token;
    print('${Constants.BASE_URL}/?name=$name&lastname=$lastname&email=$email&amount=$amount&id=$id&token=$token');

    return '${Constants.BASE_URL}/?name=$name&lastname=$lastname&email=$email&amount=$amount&id=$id&token=$token';
  }

  @override
  void onReady() {
    getReservationById();
    super.onReady();
  }

  Future<void> setCashPayment() async {
    isLoading.value = true;
    final result = await _reservationRepository.toState(
      reservation.value!.id!,
      'PAID',
      amount: reservation.value!.totalCost,
      endTime: dateToBackend(DateTime.now()),
    );
    isLoading.value = false;
    if (result) {
      Get.offAllNamed(Routes.HOME);
      showSnackBarSuccess('Pago realizado con éxito');
    }
  }

  Future<void> setReturned() async {
    isLoading.value = true;
    final result = await _reservationRepository.toState(
      reservation.value!.id!,
      'RETURNED',
    );
    isLoading.value = false;
    if (result) {
      Get.offAllNamed(Routes.HOME);
      showSnackBarSuccess('El vehículo ha sido devuelto');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
