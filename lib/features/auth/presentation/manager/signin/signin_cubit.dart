import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medi_care_hub/features/auth/domain/entities/user_entity.dart';
import 'package:medi_care_hub/features/auth/domain/repos/signin_repo.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final SigninRepo signinRepo;

  SigninCubit(this.signinRepo) : super(SigninInitial());

  Future<void> signin(String email, String password) async {
    emit(SigninLoading());
    final result = await signinRepo.signin(email, password);
    result.fold(
      (failure) => emit(SigninError(errMessage: failure.getAllErrorMessages())),
      (user) => emit(SigninSuccess(userEntity: user)),
    );
  }
}
