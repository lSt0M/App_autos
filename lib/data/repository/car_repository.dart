import 'package:valet_parking_app/data/models/car_model.dart';
import 'package:valet_parking_app/data/repository/repository_constants.dart';

class CarsRepository {
  static final CarsRepository _instance = CarsRepository._internal();
  factory CarsRepository() => _instance;
  CarsRepository._internal();

  final RepositoryConstants _repo = RepositoryConstants();

  Future<bool> createCar(CarModel car) async {
    final result = await _repo.sendPost(
      '/api/car/new',
      car.toJson(),
      isAuth: true,
    );
    if ([200, 201].contains(result.statusCode)) {
      return true;
    }
    return false;
  }

  Future<List<CarModel>> getAllCars() async {
    final result = await _repo.sendGet('/api/car');
    if (result.statusCode == 200) {
      final List<dynamic> body = result.data['cars'];
      return body.map((e) => CarModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<bool> deleteCar(String id) async {
    final result = await _repo.sendDelete(
      '/api/car/$id',
      isAuth: true,
    );
    if ([200, 201].contains(result.statusCode)) {
      return true;
    }
    return false;
  }

  Future<bool> editCar(String id, String color) async {
    final result = await _repo.sendPut(
      '/api/car/$id',
      {'color': color},
      isAuth: true,
    );
    if ([200, 201].contains(result.statusCode)) {
      return true;
    }
    return false;
  }
}
