class ParkingLotModel {
  String? id;
  String address;
  int maxCapacity;
  int? occupiedSpaces;

  ParkingLotModel({
    this.id,
    required this.address,
    required this.maxCapacity,
    this.occupiedSpaces = 0,
  });

  factory ParkingLotModel.fromJson(Map<String, dynamic> json) {
    return ParkingLotModel(
      id: json['id'],
      address: json['address'],
      maxCapacity: json['maxCapacity'], // Convertir a int, si falla asignar 0
      occupiedSpaces: json['occupiedSpaces'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'address': address,
      'maxCapacity': maxCapacity,
    };
    if (occupiedSpaces != null) {
      map['occupiedSpaces'] = occupiedSpaces!;
    }
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }
}
