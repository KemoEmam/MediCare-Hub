import 'package:flutter/material.dart';
import 'package:medi_care_hub/core/components/custom_text_form_field.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
  });
  final void Function(String?)? onSaved;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      borderRadius: 16,
      obscureText: obscureText,
      onSaved: widget.onSaved,
      suffixIcon: IconButton(
        icon: obscureText
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off),
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
      ),
      hintText: 'Password',
      hintTextStyle:
          AppTextStyles.interMedium14.copyWith(color: const Color(0xffC2C2C2)),
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
