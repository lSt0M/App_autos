import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/components/custom_success_snackbar.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/models/car_model.dart';
import 'package:valet_parking_app/data/repository/car_repository.dart';

class CarsController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxBool isButtonEnabled = RxBool(false);
  Rx<Color> pickedColor = Rx<Color>(Constants.FOCUSED_COLOR);
  RxList<CarModel> cars = RxList<CarModel>([]);
  final CarsRepository _carsRepository = CarsRepository();

  void onChangeColor(Color color) {
    pickedColor.value = color;
    newCar['color'] = color.value.toRadixString(16);
    pickedColor.refresh();
  }

  void onChangeEditColor(Color color) {
    pickedColor.value = color;
    editingCar['color'] = color.value.toRadixString(16);
    pickedColor.refresh();
  }

  Map<String, dynamic> initialState = {
    'id': null,
    'brand': null,
    'color': Constants.FOCUSED_COLOR.value.toRadixString(16),
    'carPlate': '',
    'model': '',
  };

  RxMap<String, dynamic> newCar = RxMap<String, dynamic>({
    'brand': null,
    'color': Constants.FOCUSED_COLOR.value.toRadixString(16),
    'carPlate': '',
    'model': '',
  });

  RxMap<String, dynamic> editingCar = RxMap<String, dynamic>({
    'id': null,
    'brand': null,
    'color': null,
    'carPlate': '',
    'model': '',
  });

  void startCreatingCar() {
    newCar.value = {...initialState};
    pickedColor.value = Constants.FOCUSED_COLOR;
    newCar.refresh();
    pickedColor.refresh();
  }

  void startEditingCar(CarModel car) {
    pickedColor.value = Color(
      int.parse('0x${car.color}'),
    );
    editingCar['id'] = car.id;
    editingCar['brand'] = car.brand;
    editingCar['color'] = car.color;
    editingCar['carPlate'] = car.carPlate;
    editingCar['model'] = car.model;
    pickedColor.refresh();
    editingCar.refresh();
  }

  void onChangeForm(String key, String? value) {
    newCar[key] = value;
    isButtonEnabled.value = newCar['brand'] != null && newCar['color'] != '' && newCar['carPlate'] != '' && newCar['model'] != '';
    isButtonEnabled.refresh();
  }

  void createCar() async {
    isLoading.value = true;
    final isCarRegistered = await _carsRepository.createCar(CarModel.fromJson(newCar));
    if (isCarRegistered) {
      await getAllCars();
      newCar.value = initialState;
      showSnackBarSuccess("El Auto se ha registrado correctamente");
    }
    isLoading.value = false;
  }

  void editCar() async {
    isLoading.value = true;
    final isCarEdited = await _carsRepository.editCar(editingCar['id'], editingCar['color']);
    if (isCarEdited) {
      await getAllCars();
      pickedColor.value = Constants.FOCUSED_COLOR;
      showSnackBarSuccess("El Auto se ha editado correctamente");
    }
    isLoading.value = false;
  }

  void deleteCar(String id) async {
    isLoading.value = true;
    final isCarDeleted = await _carsRepository.deleteCar(id);
    if (isCarDeleted) {
      await getAllCars();
      showSnackBarSuccess("El Auto se ha eliminado correctamente");
    }
    isLoading.value = false;
  }

  Future<void> getAllCars() async {
    cars.value = await _carsRepository.getAllCars();
  }

  @override
  void onReady() async {
    isLoading.value = true;
    await getAllCars();
    isLoading.value = false;
    super.onReady();
  }
}
