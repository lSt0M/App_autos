import 'package:get/get.dart';
import 'package:valet_parking_app/components/custom_success_snackbar.dart';
import 'package:valet_parking_app/data/models/parkinglot_model.dart';
import 'package:valet_parking_app/data/repository/parkinglot_repository.dart';

class ParkingsController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxBool isButtonEnabled = RxBool(false);
  RxBool isEdditingButtonEnabled = RxBool(false);
  RxList<ParkingLotModel> parkings = RxList<ParkingLotModel>([]);
  final ParkingsRepository _parkingsRepository = ParkingsRepository();

  Map<String, dynamic> initialState = {
    'id': null,
    'address': '',
    'maxCapacity': '',
    'occupiedSpaces': null,
  };

  RxMap<String, dynamic> newParking = RxMap<String, dynamic>({
    'id': null,
    'address': '',
    'maxCapacity': '',
    'occupiedSpaces': null,
  });

  RxMap<String, dynamic> editingParking = RxMap<String, dynamic>({
    'id': null,
    'address': '',
    'maxCapacity': '',
    'occupiedSpaces': null,
  });

  void startCreatingParking() {
    newParking.value = {...initialState};
    newParking.refresh();
  }

  void startEditingParking(ParkingLotModel parking) {
    editingParking['id'] = parking.id;
    editingParking['address'] = parking.address;
    editingParking['maxCapacity'] = parking.maxCapacity;
    editingParking['occupiedSpaces'] = parking.occupiedSpaces;
    editingParking.refresh();
  }

  void onChangeEdditingForm(String key, String? value) {
    editingParking[key] = value;
    isEdditingButtonEnabled.value = editingParking['maxCapacity'] != '' && isValidNumber(editingParking['maxCapacity']);
    isEdditingButtonEnabled.refresh();
  }

  void onChangeForm(String key, String? value) {
    newParking[key] = value;
    isButtonEnabled.value =
        newParking['address'] != '' && newParking['maxCapacity'] != '' && isValidNumber(newParking['maxCapacity']);
    isButtonEnabled.refresh();
  }

  void createParking() async {
    isLoading.value = true;
    final isCarRegistered = await _parkingsRepository.createParking({
      'address': newParking['address'],
      'maxCapacity': int.parse(newParking['maxCapacity']),
    });
    if (isCarRegistered) {
      await getAllParkings();
      newParking.value = initialState;
      showSnackBarSuccess("El Estacionamiento se ha registrado correctamente");
    }
    isLoading.value = false;
  }

  void editParking() async {
    isLoading.value = true;
    final isCarEdited = await _parkingsRepository.editParking(
      editingParking['id'],
      int.parse(
        editingParking['maxCapacity'],
      ),
    );
    if (isCarEdited) {
      await getAllParkings();
      showSnackBarSuccess("El Estacionamiento se ha editado correctamente");
    }
    isLoading.value = false;
  }

  void deleteParking(String id) async {
    isLoading.value = true;
    final isCarDeleted = await _parkingsRepository.deleteParking(id);
    if (isCarDeleted) {
      await getAllParkings();
      showSnackBarSuccess("El Estacionamiento se ha eliminado correctamente");
    }
    isLoading.value = false;
  }

  Future<void> getAllParkings() async {
    parkings.value = await _parkingsRepository.getAllParkings();
  }

  bool isValidNumber(String value) {
    return int.tryParse(value) != null;
  }

  @override
  void onReady() async {
    isLoading.value = true;
    await getAllParkings();
    isLoading.value = false;
    super.onReady();
  }
}
