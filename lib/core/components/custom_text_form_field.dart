import 'package:flutter/material.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintTextStyle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final void Function(String?)? onSaved;
  final double borderRadius; // New property for border radius

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.hintTextStyle,
    this.controller,
    this.validator,
    required this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = AppColors.primaryColor,
    this.enabledBorderColor = const Color(0xffeff2f2),
    this.suffixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.onSaved,
    this.borderRadius = 16, // Default border radius
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintTextStyle,
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor ?? Colors.grey,
        border: _borderBuilder(borderColor),
        focusedBorder: _borderBuilder(focusedBorderColor),
        enabledBorder: _borderBuilder(enabledBorderColor),
      ),
    );
  }

  OutlineInputBorder _borderBuilder(Color color, {double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(borderRadius), // Use borderRadius here
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
