import 'package:valet_parking_app/data/repository/repository_constants.dart';
import 'package:valet_parking_app/data/models/reservation_model.dart';

class ReservationRepository {
  static final ReservationRepository _instance = ReservationRepository._internal();
  factory ReservationRepository() => _instance;
  ReservationRepository._internal();

  final RepositoryConstants _repo = RepositoryConstants();

  Future<bool> createReservation(Map<String, dynamic> reservation) async {
    final result = await _repo.sendPost(
      '/api/reservation/new',
      reservation,
      isAuth: true,
    );
    if ([200, 201].contains(result.statusCode)) {
      return true;
    }
    return false;
  }

  Future<List<ReservationModel>> getAllReservations() async {
    final result = await _repo.sendGet('/api/reservation');
    if (result.statusCode == 200) {
      final List<dynamic> body = result.data['reservations'];
      return body.map((e) => ReservationModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<bool> deleteReservation(String id) async {
    final result = await _repo.sendDelete(
      '/api/reservation/$id',
      isAuth: true,
    );
    if ([200, 201].contains(result.statusCode)) {
      return true;
    }
    return false;
  }

  Future<bool> editReservation(String id, Map<String, String> body) async {
    final result = await _repo.sendPut(
      '/api/reservation/$id',
      body,
      isAuth: true,
    );
    if ([200, 201].contains(result.statusCode)) {
      return true;
    }
    return false;
  }

  Future<ReservationModel?> getReservationById(String id) async {
    final result = await _repo.sendGet(
      '/api/reservation/$id',
      isAuth: true,
    );
    if ([200, 201].contains(result.statusCode)) {
      return ReservationModel.fromJson(result.data['reservation']);
    }
    return null;
  }

  Future<bool> toState(String id, String newState, {double? amount, String? endTime}) async {
    final Map<String, dynamic> body = {
      'toState': newState,
    };
    if (amount != null) {
      body['amount'] = amount;
    }
    if (endTime != null) {
      body['endTime'] = endTime;
    }
    final result = await _repo.sendPut(
      '/api/reservation/st/$id',
      body,
      isAuth: true,
    );
    if ([200, 201].contains(result.statusCode)) {
      return true;
    }
    return false;
  }
}
