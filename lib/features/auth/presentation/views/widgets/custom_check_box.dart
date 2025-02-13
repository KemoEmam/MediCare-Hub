import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color checkColor;
  final Color backgroundColor;
  final double checkboxSize;
  final double borderThickness; // New optional parameter for border thickness

  const CustomCheckbox({
    super.key,
    required this.onChanged,
    this.initialValue = false,
    this.activeColor = Colors.transparent,
    this.checkColor = Colors.white,
    this.backgroundColor = Colors.blue, // Default to blue if not provided
    this.checkboxSize = 24.0,
    this.borderThickness = 1.0,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  void _toggleCheckbox(bool? newValue) {
    setState(() {
      _isChecked = newValue ?? false;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleCheckbox(!_isChecked),
      child: Container(
        width: widget.checkboxSize,
        height: widget.checkboxSize,
        decoration: BoxDecoration(
          color: _isChecked
              ? widget.backgroundColor
              : Colors.transparent, // Background color
          border: Border.all(
            color: _isChecked ? widget.activeColor : Colors.grey,
            width: widget.borderThickness,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: _isChecked
            ? Icon(
                Icons.check,
                size: widget.checkboxSize - 8,
                color: widget.checkColor,
              )
            : null,
      ),
    );
  }
}
