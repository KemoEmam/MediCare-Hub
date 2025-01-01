import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_care_hub/core/components/custom_button.dart';
import 'package:medi_care_hub/core/components/custom_text_form_field.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';
import 'package:medi_care_hub/features/signin/presentation/views/widgets/account_action_text.dart';
import 'package:medi_care_hub/features/signin/presentation/views/widgets/password_field.dart';
import 'package:medi_care_hub/features/signin/presentation/views/widgets/signin_header.dart';
import 'package:medi_care_hub/features/signin/presentation/views/widgets/terms_and_conditions.dart';
import '../../../../../core/themes/styles/app_colors.dart';
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
                  CustomTextFormField(
                    onSaved: (value) {
                      email = value!.trim();
                    },
                    //*adjust the validation of empty text fields and add it to notion
                    hintText: 'Email',
                    hintTextStyle: AppTextStyles.interMedium14
                        .copyWith(color: const Color(0xffC2C2C2)),
                    fillColor: const Color(0xfffdfdff),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
                  PasswordField(
                    onSaved: (value) {
                      password = value!;
                    },
                  ),
                  SizedBox(height: 16.h),
                  const ForgotPasswordHeader(),
                  SizedBox(height: 32.h),
                  CustomButton(
                    textStyle: AppTextStyles.interSemiBold16,
                    text: "Login",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
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
                    onTap: () {},
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
