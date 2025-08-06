import 'package:get_it/get_it.dart';
import '../features/auth/data/datasources/supabase_auth_datasource.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/signup_usecase.dart';
import '../features/auth/presentation/blocs/login_bloc.dart';
import '../features/auth/presentation/blocs/signup_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Data sources
  sl.registerLazySingleton(() => SupabaseAuthDatasource());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));

  // BLoCs
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => SignupBloc(signupUseCase: sl()));
}
