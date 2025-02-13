import 'package:flutter/material.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SafeArea(
          child: SignupViewBody(),
        ),
      ),
    );
  }
}
