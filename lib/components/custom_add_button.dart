import 'package:flutter/material.dart';
import 'package:valet_parking_app/constants/constants.dart';

class CustomAddButton extends StatelessWidget {
  const CustomAddButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
  });
  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constants.FOCUSED_COLOR,
      ),
      width: 60,
      height: 60,
      child: IconButton(
        iconSize: 30,
        constraints: const BoxConstraints(
          maxHeight: 60,
          maxWidth: 60,
          minWidth: 60,
          minHeight: 60,
        ),
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
