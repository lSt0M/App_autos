import 'package:flutter/material.dart';
import 'package:valet_parking_app/data/models/car_model.dart';

class CarCard extends StatelessWidget {
  final CarModel car;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const CarCard({
    super.key,
    required this.car,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: const Color(0xFF263238), // Color de fondo del Card
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(int.parse('0x${car.color}')),
          ),
          child: const Icon(
            Icons.directions_car_filled_rounded,
            size: 40,
            color: Colors.white,
          ),
        ),
        title: Text(
          car.carPlate,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              car.brand,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              car.model,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                onPressed: onEditPressed,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.white, size: 18),
                onPressed: onDeletePressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
