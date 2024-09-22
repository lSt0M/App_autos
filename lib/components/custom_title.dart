import 'package:flutter/material.dart';
import 'package:valet_parking_app/constants/constants.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 26,
        color: Constants.PRIMARY_COLOR,
      ),
    );
  }
}
