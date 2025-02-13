import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_care_hub/core/components/custom_button.dart';
import 'package:medi_care_hub/core/components/custom_text_form_field.dart';
import 'package:medi_care_hub/core/components/sign_header.dart';
import 'package:medi_care_hub/core/constants/constants.dart';
import 'package:medi_care_hub/core/router/routes.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';
import 'package:medi_care_hub/features/auth/presentation/manager/signin_cubit/signin_cubit.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/account_action_text.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/password_field.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/terms_and_conditions.dart';

import 'forgot_password_header.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String email, password;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding, vertical: kVerticalPadding),
        child: Column(
          children: [
            const SignHeader(
              title: "Welcome back!",
              description:
                  "We're excited to have you back, can't wait to\nsee what you've been up to since you last\nlogged in.",
            ),
            SizedBox(height: 36.h),
            Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                children: [
                  CustomTextFormField(
                    onSaved: (value) {
                      email = value!.trim();
                    },
                    hintText: 'Email',
                    fillColor: const Color(0xfffdfdff),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
                  PasswordField(
                    onSaved: (value) {
                      password = value!;
                    },
                  ),
                  SizedBox(height: 32.h),
                  const ForgotPasswordHeader(),
                  SizedBox(height: 32.h),
                  CustomButton(
                    text: "Login",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        context.read<SigninCubit>().signin(email, password);
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    buttonColor: AppColors.primaryColor,
                  ),
                  SizedBox(height: 32.h),
                  const TermsAndConditions(),
                  SizedBox(height: 32.h),
                  AccountActionText(
                    textBeforeAction: "Don't have an account?",
                    actionText: "Sign Up",
                    onTap: () {
                      // Navigate to Sign Up view and navigate back to Sign In view
                      context.push(Routes.signup);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
