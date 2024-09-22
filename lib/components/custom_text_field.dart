import 'package:flutter/material.dart';
import 'package:valet_parking_app/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final bool isPassword;
  final IconData prefixIcon;
  final void Function(String)? onChanged;
  final void Function()? onSuffixPressed;
  final String initialValue;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.onChanged,
    this.obscureText = false,
    this.isPassword = false,
    this.onSuffixPressed,
    this.initialValue = '',
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: TextField(
        controller: _controller,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.prefixIcon,
            color: Constants.PRIMARY_COLOR,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: widget.onSuffixPressed,
                  icon: Icon(
                    widget.obscureText ? Icons.remove_red_eye : Icons.visibility_off,
                    color: Constants.PRIMARY_COLOR,
                  ),
                )
              : null,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
