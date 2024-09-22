import 'package:flutter/material.dart';

class CustomDots extends StatelessWidget {
  final int length;
  final int index;
  final int currentPage;
  const CustomDots({
    super.key,
    required this.length,
    required this.index,
    required this.currentPage,
  });

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFF000000),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (int index) => _buildDots(
          index: index,
        ),
      ),
    );
  }
}
