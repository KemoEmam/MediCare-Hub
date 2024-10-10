import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_care_hub/core/components/custom_button.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';

class GetStartedAndDescription extends StatelessWidget {
  const GetStartedAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            'Manage and schedule all of your medical appointments easily with Docdoc to get a new experience.',
            style: AppTextStyles.interRegular10
                .copyWith(fontSize: 10.5.sp, color: AppColors.textColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomButton(
              text: 'Get Started',
              textStyle: AppTextStyles.interSemiBold16,
              onPressed: () {},
              buttonColor: AppColors.primaryColor)
        ],
      ),
    );
  }
}
