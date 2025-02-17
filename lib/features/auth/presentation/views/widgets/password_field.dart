import 'package:flutter/material.dart';
import 'package:medi_care_hub/core/components/custom_text_form_field.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';

class PasswordField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool obscureText;
  final VoidCallback onToggleObscure;
  final bool showToggleIcon;

  const PasswordField({
    super.key,
    this.onSaved,
    this.controller,
    this.validator,
    this.labelText,
    required this.obscureText,
    required this.onToggleObscure,
    this.showToggleIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      //*use below code in the signup view if confirmPassword is needed with controller
      //*&& add controller to the password field with validator
      // validator: (value) {
      //             if (value!.isEmpty) {
      //               return 'Confirm Password is required';
      //             } else if (value != _passwordController.text) {
      //               return 'Passwords do not match';
      //             } else {
      //               return null;
      //             }
      //           },
      validator: validator,
      controller: controller,
      fillColor: const Color(0xfffdfdff),
      borderRadius: 16,
      obscureText: obscureText,
      onSaved: onSaved,
      suffixIcon: showToggleIcon
          ? IconButton(
              icon: obscureText
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              onPressed: onToggleObscure,
            )
          : null,
      labelText: labelText ?? 'Password',
      labelTextStyle:
          AppTextStyles.interMedium14.copyWith(color: const Color(0xffC2C2C2)),
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
