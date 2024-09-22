import 'package:flutter/material.dart';
import 'package:valet_parking_app/data/models/parkinglot_model.dart';

class ParkingCard extends StatelessWidget {
  final ParkingLotModel parking;
  final VoidCallback onTap;
  final VoidCallback onDeletePressed;

  const ParkingCard({
    super.key,
    required this.parking,
    required this.onTap,
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
        title: Text(
          parking.address,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Capacidad máxima: ${parking.maxCapacity.toString()}',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Espacios ocupados: ${parking.occupiedSpaces.toString()}',
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
                onPressed: onTap,
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
