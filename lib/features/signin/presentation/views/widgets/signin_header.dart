import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';

class SigninHeader extends StatelessWidget {
  const SigninHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back',
          style: AppTextStyles.interBold24.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "We're excited to have you back, can't wait to\nsee what you've been up to since you last\nlogged in.",
          style: AppTextStyles.interRegular14.copyWith(
            color: AppColors.textColor,
            height: 1.3.sp,
          ),
        ),
      ],
    );
  }
}
