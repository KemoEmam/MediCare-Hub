import 'package:dartz/dartz.dart';
import 'package:medi_care_hub/core/constants/api_constants.dart';
import 'package:medi_care_hub/core/errors/error_model/error_model.dart';
import 'package:medi_care_hub/core/helper/log_helper.dart';
import 'package:medi_care_hub/core/helper/shared_prefs.dart';
import 'package:medi_care_hub/core/services/api_no_refresh_service.dart';
import 'package:medi_care_hub/core/services/token_service.dart';
import 'package:medi_care_hub/features/auth/data/models/signin_user_model/signin_user_model.dart';
import 'package:medi_care_hub/features/auth/domain/entities/user_entity.dart';
import 'package:medi_care_hub/features/auth/domain/repos/signin_repo.dart';

class SigninRepoImpl implements SigninRepo {
  final ApiService _apiService;
  final TokenService _tokenService;

  SigninRepoImpl(this._apiService, this._tokenService);

  @override
  Future<Either<ErrorModel, UserEntity>> signin(
      String email, String password) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        endpoint: ApiConstants.signinEP,
        data: {'email': email, 'password': password},
      );

      final user = SigninUserModel.fromJson(response);
      await Prefs.saveString("user", user.data!.username!);
      // await saveUserDataa(user);

      if (user.data?.token != null) {
        await _tokenService.saveToken(
            'accessToken', user.data!.token!); //access token
      }
      //always have refresh and access token
      // await _tokenService.saveToken('refreshToken', user.data!.token!);

      return right(user);
    } on ErrorModel catch (e) {
      return left(e);
    } catch (e) {
      LogHelper.warning('Exception in SigninRepoImpl.signin: $e');
      return left(ErrorModel(message: e.toString(), status: false, code: 500));
    }
  }

//*to test this method & and is this considered caching user data
  // Future<void> saveUserDataa(SigninUserModel user) async {
  //   var jsonUser = jsonEncode(user);
  //   await Prefs.saveString(kUserData, jsonUser);
  // }

  // @override
  // Future<void> saveUserData(UserEntity user) async {
  //   jsonEncode(SigninUserModel.fromJson(response));
  // }
}
