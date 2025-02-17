import 'package:get_it/get_it.dart';
import 'package:medi_care_hub/core/services/api_no_refresh_service.dart';
import 'package:medi_care_hub/core/services/token_service.dart';
import 'package:medi_care_hub/features/auth/data/repo_impl/signin_repo_impl.dart';
import 'package:medi_care_hub/features/auth/domain/repos/signin_repo.dart';
import 'package:medi_care_hub/features/auth/presentation/manager/signin/signin_cubit.dart';

final sl = GetIt.instance;

void serviceLocator() {
  sl.registerLazySingleton<TokenService>(() => TokenService());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<TokenService>()));

  sl.registerLazySingleton<SigninRepo>(
      () => SigninRepoImpl(sl<ApiService>(), sl<TokenService>()));
  sl.registerFactory<SigninCubit>(() => SigninCubit(sl<SigninRepo>()));
}
