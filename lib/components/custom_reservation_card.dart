import 'package:flutter/material.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/models/reservation_model.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/data/utils/date_formatter.dart';
import 'package:valet_parking_app/data/utils/state_formatter.dart';

class CustomReservationCard extends StatelessWidget {
  final UserService userService = UserService();
  final ReservationModel reservation;
  final VoidCallback onViewDetailPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onEditPressed;

  CustomReservationCard({
    super.key,
    required this.reservation,
    required this.onViewDetailPressed,
    required this.onDeletePressed,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: const Color(0xFF263238), // PRIMARY_COLOR
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Fecha y hora de reserva:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // WHITE_COLOR
                  ),
                ),
                Text(
                  dateToDisplayFromBackend(reservation.startTime),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // WHITE_COLOR
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Detalles del estacionamiento",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, // WHITE_COLOR
              ),
            ),
            const SizedBox(height: 8),
            Text(
              reservation.parkingLot.address,
              style: const TextStyle(color: Colors.white), // WHITE_COLOR
            ),
            Text(
              'Capacidad máxima: ${reservation.parkingLot.maxCapacity}',
              style: const TextStyle(color: Colors.white), // WHITE_COLOR
            ),
            const SizedBox(height: 16),
            const Text(
              "Detalles del automóvil",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, // WHITE_COLOR
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Placa: ${reservation.car.carPlate}',
              style: const TextStyle(color: Colors.white), // WHITE_COLOR
            ),
            Text(
              reservation.car.brand,
              style: const TextStyle(color: Colors.white), // WHITE_COLOR
            ),
            Text(
              reservation.car.model,
              style: const TextStyle(color: Colors.white), // WHITE_COLOR
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: userService.getRole() == 'USER_ROLE' && reservation.currentState == 'CREATED'
                  ? [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.red, // FOCUSED_COLOR
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: onDeletePressed,
                          icon: const Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.amberAccent[700], // FOCUSED_COLOR
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: onEditPressed,
                          icon: const Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.green, // FOCUSED_COLOR
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: onViewDetailPressed,
                          icon: const Icon(Icons.remove_red_eye, color: Colors.white),
                        ),
                      ),
                      Icon(
                        Icons.directions_car,
                        color: Color(
                          int.parse('0x${reservation.car.color}'),
                        ),
                        size: 40,
                      ),
                    ]
                  : [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.green, // FOCUSED_COLOR
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: onViewDetailPressed,
                          icon: const Icon(Icons.remove_red_eye, color: Colors.white),
                        ),
                      ),
                      Icon(
                        Icons.directions_car,
                        color: Color(
                          int.parse('0x${reservation.car.color}'),
                        ),
                        size: 40,
                      ),
                    ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white, // FOCUSED_COLOR
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    stateToWord(reservation.currentState),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Constants.FOCUSED_COLOR, // WHITE_COLOR
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
