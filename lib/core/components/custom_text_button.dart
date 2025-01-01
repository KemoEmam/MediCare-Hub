import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final double? fontSize;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? outerPadding; // Added padding parameter

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.fontSize,
    this.textStyle,
    this.outerPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        textStyle: textStyle,
        padding: outerPadding ?? EdgeInsets.zero,
      ),
      child: Text(text),
    );
  }
}
