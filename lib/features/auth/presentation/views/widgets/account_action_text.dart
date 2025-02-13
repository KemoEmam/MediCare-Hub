import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medi_care_hub/core/themes/styles/app_colors.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';

class AccountActionText extends StatelessWidget {
  final String textBeforeAction;
  final String actionText;
  final VoidCallback onTap;

  const AccountActionText({
    super.key,
    required this.textBeforeAction,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: textBeforeAction, style: AppTextStyles.interSemiBold12),
          const WidgetSpan(
            child: SizedBox(width: 5),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: actionText,
            style: AppTextStyles.interSemiBold12
                .copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
