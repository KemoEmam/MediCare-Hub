import 'package:flutter/material.dart';
import 'package:medi_care_hub/features/login/presentation/views/widgets/signin_view_body.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SigninViewBody(),
      ),
    );
  }
}
