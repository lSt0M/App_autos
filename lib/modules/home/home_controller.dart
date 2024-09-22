import 'package:get/get.dart';
import 'package:valet_parking_app/components/custom_success_snackbar.dart';
import 'package:valet_parking_app/data/models/car_model.dart';
import 'package:valet_parking_app/data/models/parkinglot_model.dart';
import 'package:valet_parking_app/data/repository/car_repository.dart';
import 'package:valet_parking_app/data/repository/parkinglot_repository.dart';
import 'package:valet_parking_app/data/repository/reservation_repository.dart';
import 'package:valet_parking_app/data/models/reservation_model.dart';
import 'package:valet_parking_app/data/utils/date_formatter.dart';

class HomeController extends GetxController {
  RxList<CarModel> cars = RxList<CarModel>([]);
  RxList<ParkingLotModel> parkings = RxList<ParkingLotModel>([]);
  RxList<ReservationModel> reservations = RxList<ReservationModel>([]);
  RxBool isLoading = RxBool(false);
  final CarsRepository _carsRepository = CarsRepository();
  final ParkingsRepository _parkingsRepository = ParkingsRepository();
  final ReservationRepository _reservationRepository = ReservationRepository();
  final reservationInitialState = {
    "id": null,
    "date": getDateTimeNow().hour < 22
        ? getDateTimeNow()
        : getDateTimeNow().add(
            const Duration(days: 1),
          ),
    "car": null,
    "parKing": null,
    "currentStep": 0,
  };

  RxMap<String, dynamic> reservation = RxMap<String, dynamic>({
    "id": null,
    "date": getDateTimeNow().hour < 22
        ? getDateTimeNow()
        : getDateTimeNow().add(
            const Duration(days: 1),
          ),
    "car": null,
    "parKing": null,
    "currentStep": 0,
  });

  void setCurrentStep(int index) {
    reservation['currentStep'] = index;
    reservation.refresh();
  }

  void onOpenDialog(ReservationModel? rm) {
    if (rm != null) {
      reservation.value = {
        "id": rm.id,
        "date": dateFromBackend(rm.startTime),
        "car": rm.car.id,
        "parking": rm.parkingLot.id,
        "currentStep": 0,
      };
    } else {
      reservation.value = {...reservationInitialState};
    }
    reservation.refresh();
  }

  Future<void> createReservation() async {
    isLoading.value = true;
    final isCarDeleted = await _reservationRepository.createReservation({
      'startTime': dateToBackend(reservation['date'] as DateTime),
      'car': reservation['car'],
      'parkingLot': reservation['parking'],
    });
    if (isCarDeleted) {
      await getAllData();
      showSnackBarSuccess("Se ha registrado la reserva correctamente");
    }
    isLoading.value = false;
  }

  Future<void> deleteReservation(String id) async {
    isLoading.value = true;
    final isDeleted = await _reservationRepository.deleteReservation(id);
    if (isDeleted) {
      await getAllData();
      showSnackBarSuccess("Se ha eliminado la reserva correctamente");
    }
    isLoading.value = false;
  }

  Future<void> editReservation() async {
    isLoading.value = true;
    final isEdited = await _reservationRepository.editReservation(reservation['id'], {
      'startTime': dateToBackend(reservation['date'] as DateTime),
      'car': reservation['car'],
      'parkingLot': reservation['parking'],
    });
    if (isEdited) {
      await getAllData();
      showSnackBarSuccess("Se ha editado la reserva correctamente");
    }
    isLoading.value = false;
  }

  Future<void> getAllData() async {
    isLoading.value = true;
    final List<dynamic> result = await Future.wait([
      _carsRepository.getAllCars(),
      _parkingsRepository.getAllParkings(),
      _reservationRepository.getAllReservations(),
    ]);

    cars.value = result[0];
    parkings.value = result[1];
    reservations.value = result[2];
    isLoading.value = false;
  }

  @override
  void onReady() async {
    isLoading.value = true;
    await getAllData();
    isLoading.value = false;
    super.onReady();
  }
}
