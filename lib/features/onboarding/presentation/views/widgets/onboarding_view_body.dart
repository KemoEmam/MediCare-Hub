import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_care_hub/features/onboarding/presentation/views/widgets/doc_logo_and_name.dart';
import 'package:medi_care_hub/features/onboarding/presentation/views/widgets/doctor_image_and_text.dart';
import 'package:medi_care_hub/features/onboarding/presentation/views/widgets/get_started_and_description.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 25.h),
        child: Column(
          children: [
            const DocLogoAndName(),
            SizedBox(height: 30.h),
            const DoctorImageAndText(),
            SizedBox(height: 18.h),
            const GetStartedAndDescription(),
            // SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
