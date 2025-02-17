import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_care_hub/core/components/custom_text_button.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';
import 'package:medi_care_hub/features/auth/presentation/manager/auth_ui_actions/auth_ui_actions_cubit.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/custom_check_box.dart';

import '../../../../../core/themes/styles/app_colors.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthUiActionsCubit>();
    return Row(
      children: [
        BlocBuilder<AuthUiActionsCubit, AuthUiActionsState>(
          builder: (context, state) {
            return CustomCheckbox(
              isChecked: cubit.signinIsChecked,
              borderThickness: 1.8.w,
              onChanged: (value) => cubit.signinRememberMe(),
            );
          },
        ),
        SizedBox(width: 8.w),
        Text(
          "Remember me",
          style: AppTextStyles.interRegular12.copyWith(
            color: const Color(0xff9E9E9E),
          ),
        ),
        const Spacer(),
        CustomTextButton(
          text: "Forgot Password?",
          textColor: AppColors.primaryColor,
          textStyle: AppTextStyles.interRegular12,
          onPressed: () {},
        ),
      ],
    );
  }
}
