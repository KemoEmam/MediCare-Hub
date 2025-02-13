import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care_hub/features/auth/domain/entities/user_entity.dart';
import 'package:medi_care_hub/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:medi_care_hub/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthCubit, UserEntity?>(
          builder: (context, state) {
            return Text('Welcome ${state?.username ?? 'User'}');
          },
        ),
      ),
      body: const HomeViewBody(),
    );
  }
}
