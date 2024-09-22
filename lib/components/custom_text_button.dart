import 'package:flutter/material.dart';
import 'package:valet_parking_app/constants/constants.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color textColor;
  final bool isEnabled;
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Constants.PRIMARY_COLOR,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
