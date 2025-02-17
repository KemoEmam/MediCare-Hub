import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color checkColor;
  final Color backgroundColor;
  final double checkboxSize;
  final double borderThickness;

  const CustomCheckbox({
    super.key,
    required this.onChanged,
    required this.isChecked,
    this.activeColor = Colors.transparent,
    this.checkColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.checkboxSize = 24.0,
    this.borderThickness = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: checkboxSize,
        height: checkboxSize,
        decoration: BoxDecoration(
          color: isChecked ? backgroundColor : Colors.transparent,
          border: Border.all(
            color: isChecked ? activeColor : Colors.grey,
            width: borderThickness,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                size: checkboxSize - 8,
                color: checkColor,
              )
            : null,
      ),
    );
  }
}
