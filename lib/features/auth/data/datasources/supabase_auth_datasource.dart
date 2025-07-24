import '../../domain/entities/user_entity.dart';

class SupabaseAuthDatasource {
  Future<UserEntity?> login(String email, String password) async {
    // TODO: Implement actual Supabase login
    return UserEntity(); // Stub
  }

  Future<UserEntity?> signup(String name, String email, String password) async {
    // TODO: Implement actual Supabase signup
    return UserEntity(); // Stub
  }
}
