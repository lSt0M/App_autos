import 'package:flutter/material.dart';
import 'package:valet_parking_app/constants/constants.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.hint,
    required this.prefixIcon,
  });
  final List<String> items;
  final String? selectedItem;
  final Function(String?) onChanged;
  final String hint;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Constants.PRIMARY_COLOR),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              const SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(prefixIcon, color: Constants.PRIMARY_COLOR, size: 30),
                ],
              ),
            ],
          ),
          Center(
            child: DropdownButton<String?>(
              padding: const EdgeInsets.only(right: 10, left: 45),
              hint: Text(
                hint,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              menuMaxHeight: 300,
              value: selectedItem,
              onChanged: onChanged,
              isExpanded: true,
              underline: const SizedBox(),
              items: items.map<DropdownMenuItem<String?>>((String value) {
                return DropdownMenuItem<String?>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
