import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forbidden_pack/forbidden_pack.dart';
import 'package:medi_care_hub/core/components/custom_text_form_field.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';
import 'package:medi_care_hub/features/login/presentation/views/widgets/custom_check_box.dart';
import 'package:medi_care_hub/features/login/presentation/views/widgets/password_field.dart';
import 'package:medi_care_hub/features/login/presentation/views/widgets/signin_header.dart';

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
                    //*adjust the validation of empty text fields and add it to notion
                    hintText: 'Email',
                    hintTextStyle: AppTextStyles.interMedium14
                        .copyWith(color: const Color(0xffC2C2C2)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
                  const PasswordField(),
                  SizedBox(height: 16.h),
                  const ForgotPasswordHeader(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
