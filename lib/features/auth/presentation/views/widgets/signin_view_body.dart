import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_care_hub/core/components/custom_button.dart';
import 'package:medi_care_hub/core/components/custom_text_form_field.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';
import 'package:medi_care_hub/features/auth/presentation/manager/signin_cubit/signin_cubit.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/account_action_text.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/password_field.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/signin_header.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            const SigninHeader(),
            SizedBox(height: 36.h),
            Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                children: [
                  // Email Field
                  CustomTextFormField(
                    onSaved: (value) {
                      email = value!.trim();
                    },
                    hintText: 'Email',
                    hintTextStyle: AppTextStyles.interMedium14
                        .copyWith(color: const Color(0xffC2C2C2)),
                    fillColor: const Color(0xfffdfdff),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),

                  // Password Field
                  PasswordField(
                    onSaved: (value) {
                      password = value!;
                    },
                    // You can also add a validator here if needed.
                  ),
                  SizedBox(height: 16.h),
                  // CustomPhoneFormField(
                  //   labelText: 'Phone Number',
                  //   labelTextStyle: AppTextStyles.interMedium12
                  //       .copyWith(color: const Color(0xFF949D9E)),
                  //   hintText: 'Phone Number',
                  //   hintTextStyle: AppTextStyles.interMedium12
                  //       .copyWith(color: const Color(0xffC2C2C2)),
                  // ),
                  SizedBox(height: 32.h),

                  const ForgotPasswordHeader(),
                  SizedBox(height: 32.h),

                  // Login Button
                  CustomButton(
                    textStyle: AppTextStyles.interSemiBold16,
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
                      // Navigate to Sign Up view
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
