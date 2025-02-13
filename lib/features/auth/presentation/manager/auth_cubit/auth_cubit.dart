import 'package:bloc/bloc.dart';
import 'package:medi_care_hub/core/helper/shared_prefs.dart';
import 'package:medi_care_hub/features/auth/domain/entities/user_entity.dart';

class AuthCubit extends Cubit<UserEntity?> {
  AuthCubit() : super(null);

  Future<void> loadUser() async {
    final username = await Prefs.getString('user');
    if (username != null) {
      emit(UserEntity(username: username));
    }
  }
}
