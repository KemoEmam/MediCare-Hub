import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'auth_ui_actions_state.dart';

class AuthUiActionsCubit extends Cubit<AuthUiActionsState> {
  AuthUiActionsCubit() : super(AuthUiActionsInitial());
//signin form
  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();
  AutovalidateMode signinAutovalidateMode = AutovalidateMode.disabled;
  String signinEmail = '';
  String signinPassword = '';
  bool signinObscureText = true;
  bool signinIsChecked = false;

//signin related methods
  void signinToggleObscureText() {
    signinObscureText = !signinObscureText;
    emit(AuthUiActionsInitial());
  }

  void signinRememberMe() {
    signinIsChecked = !signinIsChecked;
    emit(AuthUiActionsInitial());
  }

  void singinEmailChanged(String value) {
    signinEmail = value;
  }

  void signinPasswordChanged(String value) {
    signinPassword = value;
  }
}
