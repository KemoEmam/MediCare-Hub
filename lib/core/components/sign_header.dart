import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';

class SignHeader extends StatelessWidget {
  const SignHeader({super.key, required this.title, required this.description});

  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.interBold24.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          description,
          style: AppTextStyles.interRegular14.copyWith(
            color: AppColors.textColor,
            height: 1.2.sp,
          ),
        ),
      ],
    );
  }
}
