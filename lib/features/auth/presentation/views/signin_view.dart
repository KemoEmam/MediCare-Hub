import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_care_hub/core/components/custom_progress_hud.dart';
import 'package:medi_care_hub/core/components/show_snack_bar.dart';
import 'package:medi_care_hub/core/router/routes.dart';
import 'package:medi_care_hub/features/auth/presentation/manager/signin_cubit/signin_cubit.dart';
import 'package:medi_care_hub/features/auth/presentation/views/widgets/signin_view_body.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state is SigninSuccess) {
              context.go(Routes.home);
            }
            if (state is SigninError) {
              showSnackBar(
                context: context,
                title: "Error",
                message: state.errMessage,
                backgroundColor: Colors.red,
                icon: Icons.error,
              );
            }
          },
          builder: (context, state) {
            return CustomProgressHud(
              isLoading: state is SigninLoading ? true : false,
              child: const SigninViewBody(),
            );
          },
        ),
      ),
    );
  }
}
