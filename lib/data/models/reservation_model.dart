import 'package:valet_parking_app/data/models/car_model.dart';
import 'package:valet_parking_app/data/models/parkinglot_model.dart';

class ReservationModel {
  String? id;
  String? endTime;
  double? totalCost;
  String startTime;
  String currentState;
  ParkingLotModel parkingLot;
  CarModel car;

  ReservationModel({
    this.id,
    this.endTime,
    this.totalCost,
    required this.startTime,
    required this.currentState,
    required this.parkingLot,
    required this.car,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      currentState: json['currentState'],
      parkingLot: ParkingLotModel.fromJson(json['parkingLot']),
      totalCost: json['totalCost'] != null ? double.parse(json['totalCost'].toString()) : null,
      car: CarModel.fromJson(json['car']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
      'currentState': currentState,
      'parkingLot': parkingLot.toJson(),
      'totalCost': totalCost,
      'car': car.toJson(),
    };
  }
}
