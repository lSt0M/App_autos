import 'package:flutter/material.dart';
import 'package:valet_parking_app/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color color, textColor;
  final bool isEnabled;
  final bool isLoading;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.color = Constants.PRIMARY_COLOR,
    this.textColor = Constants.WHITE_COLOR,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? color : Colors.grey[300],
          disabledBackgroundColor: isLoading ? color : null,
          foregroundColor: textColor,
          disabledForegroundColor: isLoading ? textColor : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: isEnabled && !isLoading ? onPressed : null,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Change the color here
                )
              : Text(
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
