import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';
import 'package:medi_care_hub/core/themes/styles/app_images.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';

class DoctorImageAndText extends StatelessWidget {
  const DoctorImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: SvgPicture.asset(
            AppImages.imagesOnboardingBackground,
          ),
        ),
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [.14, .4],
            ),
          ),
          child: Image.asset(AppImages.imagesOnboardingDoctor),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Text(
            "Best Doctor\nAppointment App",
            textAlign: TextAlign.center,
            style: AppTextStyles.interBold32
                .copyWith(color: AppColors.primaryColor, height: 1.5),
          ),
        ),
      ],
    );
  }
}
