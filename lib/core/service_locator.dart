import 'package:get_it/get_it.dart';
import '../features/auth/data/datasources/supabase_auth_datasource.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/signup_usecase.dart';
import '../features/auth/presentation/blocs/login_bloc.dart';
import '../features/auth/presentation/blocs/signup_bloc.dart';
import '../features/navigation/presentation/bloc/navigation_bloc.dart';
import '../features/cart/presentation/bloc/cart_bloc.dart';
import '../features/profile/data/datasources/profile_local_datasource.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/repositories/profile_repository.dart';
import '../features/profile/domain/usecases/get_user_profile_usecase.dart';
import '../features/profile/domain/usecases/update_profile_usecase.dart';
import '../features/profile/domain/usecases/logout_usecase.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';
import 'theme/theme_cubit.dart';

final sl = GetIt.instance;

void init() {
  // Data sources
  sl.registerLazySingleton(() => SupabaseAuthDatasource());
  sl.registerLazySingleton<ProfileLocalDataSource>(() => ProfileLocalDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(localDataSource: sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // BLoCs - Using the correct implementations from features directory
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => SignupBloc(signupUseCase: sl()));
  sl.registerFactory(() => NavigationBloc());
  sl.registerFactory(() => CartBloc());
  sl.registerFactory(() => ProfileBloc(
    getUserProfileUseCase: sl(),
    updateProfileUseCase: sl(),
    logoutUseCase: sl(),
  ));

  // Theme
  sl.registerLazySingleton(() => ThemeCubit());
}
