import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_care_hub/core/components/custom_button.dart';
import 'package:medi_care_hub/core/components/custom_text_form_field.dart';
import 'package:medi_care_hub/core/components/sign_header.dart';
import 'package:medi_care_hub/core/constants/constants.dart';
import 'package:medi_care_hub/core/helper/app_regex.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/custom_phone.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/password_field.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late String name, email, phoneNumber;
  bool obscureText = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding, vertical: kVerticalPadding),
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: SingleChildScrollView(
          child: Column(
            spacing: 16.h,
            children: [
              const SignHeader(
                  title: 'Create Account',
                  description:
                      "Sign up now and start exploring all that our\napp has to offer. We're excited to welcome\nyou to our community!"),
              CustomTextFormField(
                labelText: 'Name',
                regex: AppRegex.name,
                regexErrorMessage: "Invalid name",
                onSaved: (value) {
                  name = value!.trim();
                },
              ),
              CustomTextFormField(
                labelText: 'Email',
                regex: AppRegex.email,
                regexErrorMessage: "Invalid email",
                onSaved: (value) {
                  email = value!.trim();
                },
              ),
              PasswordField(
                obscureText: obscureText,
                onToggleObscure: () =>
                    setState(() => obscureText = !obscureText),
                controller: _passwordController,
                validator: (value) {
                  return AppRegex.passwordValidator(value);
                },
              ),
              PasswordField(
                obscureText: obscureText,
                onToggleObscure: () =>
                    setState(() => obscureText = !obscureText),
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Confirm Password is required';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  } else {
                    return null;
                  }
                },
              ),
              const CustomPhoneFormField(
                labelText: '   Phone Number',
              ),
              CustomButton(
                text: 'Create Account',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                buttonColor: AppColors.primaryColor,
              ),
              SizedBox(height: 16.h),
              const TermsAndConditions()
            ],
          ),
        ),
      ),
    );
  }
}
