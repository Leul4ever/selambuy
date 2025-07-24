import '../repositories/auth_repository.dart';

class LoginResult {
  final bool isSuccess;
  final String? errorMessage;
  const LoginResult({required this.isSuccess, this.errorMessage});
}

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<LoginResult> call(
      {required String email, required String password}) async {
    try {
      final user = await repository.login(email, password);
      if (user != null) {
        return const LoginResult(isSuccess: true);
      } else {
        return const LoginResult(
            isSuccess: false, errorMessage: 'Invalid credentials');
      }
    } catch (e) {
      return LoginResult(isSuccess: false, errorMessage: e.toString());
    }
  }
}
