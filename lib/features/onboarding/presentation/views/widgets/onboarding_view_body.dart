import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_care_hub/features/onboarding/presentation/views/widgets/doc_logo_and_name.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
      child: const Column(
        children: [
          DocLogoAndName(),
        ],
      ),
    );
  }
}
