import 'package:valet_parking_app/data/models/parkinglot_model.dart';
import 'package:valet_parking_app/data/repository/repository_constants.dart';

class ParkingsRepository {
  static final ParkingsRepository _instance = ParkingsRepository._internal();
  factory ParkingsRepository() => _instance;
  ParkingsRepository._internal();

  final RepositoryConstants _repo = RepositoryConstants();

  Future<bool> createParking(Map<String, dynamic> parking) async {
    final result = await _repo.sendPost(
      '/api/parkinglot/new',
      parking,
      isAuth: true,
    );
    if ([200, 201].contains(result.statusCode)) {
      return true;
    }
    return false;
  }

  Future<List<ParkingLotModel>> getAllParkings() async {
    final result = await _repo.sendGet('/api/parkinglot');
    if (result.statusCode == 200) {
      final List<dynamic> body = result.data['parkingLots'];
      return body.map((e) => ParkingLotModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<bool> deleteParking(String id) async {
    final result = await _repo.sendDelete(
      '/api/parkinglot/$id',
      isAuth: true,
    );
    if ([200, 201].contains(result.statusCode)) {
      return true;
    }
    return false;
  }

  Future<bool> editParking(String id, int maxCapacity) async {
    final result = await _repo.sendPut(
      '/api/parkinglot/$id',
      {
        'maxCapacity': maxCapacity,
      },
      isAuth: true,
    );
    if ([200, 201].contains(result.statusCode)) {
      return true;
    }
    return false;
  }
}
