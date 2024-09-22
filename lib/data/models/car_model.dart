class CarModel {
  String? id;
  String brand;
  String model;
  String color;
  String carPlate;

  CarModel({
    this.id,
    required this.brand,
    required this.model,
    required this.color,
    required this.carPlate,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      brand: json['brand'],
      model: json['model'],
      color: json['color'],
      carPlate: json['carPlate'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'brand': brand,
      'model': model,
      'color': color,
      'carPlate': carPlate,
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }
}
