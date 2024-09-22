import 'package:flutter/material.dart';

class CustomSubtitle extends StatelessWidget {
  const CustomSubtitle({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: Colors.black45,
      ),
    );
  }
}
