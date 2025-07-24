import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/supabase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthDatasource datasource;
  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserEntity?> login(String email, String password) async {
    return await datasource.login(email, password);
  }

  @override
  Future<UserEntity?> signup(String name, String email, String password) async {
    return await datasource.signup(name, email, password);
  }
}
