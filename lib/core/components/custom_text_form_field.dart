import 'package:flutter/material.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
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
  final double borderRadius;
  final Color? fillColor;
  final RegExp? regex;
  final String? regexErrorMessage;
  final String labelText;
  final TextStyle? labelTextStyle;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.labelTextStyle,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
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
    this.fillColor,
    this.regex,
    this.regexErrorMessage,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator ?? _validate,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelTextStyle ??
            AppTextStyles.interMedium14
                .copyWith(color: const Color(0xffC2C2C2)),
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor ?? Colors.grey,
        fillColor: fillColor,
        filled: fillColor != null,
        // border: _borderBuilder(borderColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
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

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }

    // Trim leading and trailing spaces but keep middle spaces
    String trimmedValue = value.trim();

    if (regex != null && !regex!.hasMatch(trimmedValue)) {
      return regexErrorMessage ?? "Invalid input";
    }

    return null;
  }
}
