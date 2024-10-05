import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medi_care_hub/core/themes/styles/app_images.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';

class DocLogoAndName extends StatelessWidget {
  const DocLogoAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppImages.imagesLogo),
        SizedBox(
          width: 10.w,
        ),
        Text("DocDoc", style: AppTextStyles.interBold24)
      ],
    );
  }
}
