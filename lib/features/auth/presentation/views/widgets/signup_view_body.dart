import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_care_hub/core/components/custom_button.dart';
import 'package:medi_care_hub/core/components/custom_text_form_field.dart';
import 'package:medi_care_hub/core/components/sign_header.dart';
import 'package:medi_care_hub/core/constants/constants.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/custom_phone.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding, vertical: kVerticalPadding),
      child: Form(
        child: Column(
          spacing: 16.h,
          children: [
            const SignHeader(
                title: 'Create Account',
                description:
                    "Sign up now and start exploring all that our\napp has to offer. We're excited to welcome\nyou to our community!"),
            const CustomTextFormField(
                hintText: 'Name', keyboardType: TextInputType.text),
            const CustomTextFormField(
                hintText: 'Email', keyboardType: TextInputType.emailAddress),
            const CustomTextFormField(
                hintText: 'Password',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword),
            const CustomTextFormField(
                hintText: 'Confirm Password',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword),
            const CustomPhoneFormField(
                hintText: 'Phone Number', labelText: '   Phone Number'),
            CustomButton(
                text: 'Create Account',
                onPressed: () {},
                buttonColor: AppColors.primaryColor),
            SizedBox(height: 16.h),
            const TermsAndConditions()
          ],
        ),
      ),
    );
  }
}
