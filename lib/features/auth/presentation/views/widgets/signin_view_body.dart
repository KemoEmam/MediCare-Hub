import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_care_hub/core/components/custom_button.dart';
import 'package:medi_care_hub/core/components/custom_text_form_field.dart';
import 'package:medi_care_hub/core/components/sign_header.dart';
import 'package:medi_care_hub/core/constants/constants.dart';
import 'package:medi_care_hub/core/helper/app_regex.dart';
import 'package:medi_care_hub/core/router/routes.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';
import 'package:medi_care_hub/features/auth/presentation/manager/auth_ui_actions/auth_ui_actions_cubit.dart';
import 'package:medi_care_hub/features/auth/presentation/manager/signin/signin_cubit.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/account_action_text.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/password_field.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/terms_and_conditions.dart';

import 'forgot_password_header.dart';

class SigninViewBody extends StatelessWidget {
  const SigninViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthUiActionsCubit>();
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
              key: cubit.signinFormKey,
              autovalidateMode: cubit.signinAutovalidateMode,
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: 'Email',
                    regex: AppRegex.email,
                    regexErrorMessage: "Invalid email address",
                    onSaved: (value) {
                      cubit.signinEmail = value!.trim();
                    },
                    fillColor: const Color(0xfffdfdff),
                  ),
                  SizedBox(height: 16.h),
                  BlocBuilder<AuthUiActionsCubit, AuthUiActionsState>(
                    builder: (context, state) {
                      return PasswordField(
                        obscureText: cubit.signinObscureText,
                        onToggleObscure: () => cubit.signinToggleObscureText(),
                        onSaved: (value) {
                          cubit.signinPassword = value!;
                        },
                      );
                    },
                  ),
                  SizedBox(height: 32.h),
                  const ForgotPasswordHeader(),
                  SizedBox(height: 32.h),
                  CustomButton(
                    text: "Login",
                    onPressed: () {
                      toggleSignin(cubit, context);
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

  void toggleSignin(AuthUiActionsCubit cubit, BuildContext context) {
    if (cubit.signinFormKey.currentState!.validate()) {
      cubit.signinFormKey.currentState!.save();
      context
          .read<SigninCubit>()
          .signin(cubit.signinEmail, cubit.signinPassword);
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
