import 'package:flutter/material.dart';
import 'package:medi_care_hub/features/otp/views/widgets/pin.dart';

class OtpViewBody extends StatelessWidget {
  const OtpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomOtpField(
          length: 6,
          onOtpCompleted: (otp) => print(otp),
          onResendOtp: () => print("Resend OTP"),
        ),
      ],
    );
  }
}
