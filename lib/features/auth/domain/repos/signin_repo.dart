import 'package:dartz/dartz.dart';
import 'package:medi_care_hub/core/errors/error_model/error_model.dart';
import 'package:medi_care_hub/features/auth/domain/entities/user_entity.dart';

abstract class SigninRepo {
  Future<Either<ErrorModel, UserEntity>> signin(String email, String password);
  //  Future<UserEntity> signUp(String name, String phone, String email, String password);
  // Future<void> saveUserData(UserEntity user);
  // Future<UserEntity?> getUserData();
}
