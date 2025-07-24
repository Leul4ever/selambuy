import '../repositories/auth_repository.dart';

class SignupResult {
  final bool isSuccess;
  final String? errorMessage;
  const SignupResult({required this.isSuccess, this.errorMessage});
}

class SignupUseCase {
  final AuthRepository repository;
  SignupUseCase(this.repository);

  Future<SignupResult> call(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await repository.signup(name, email, password);
      if (user != null) {
        return const SignupResult(isSuccess: true);
      } else {
        return const SignupResult(
            isSuccess: false, errorMessage: 'Signup failed');
      }
    } catch (e) {
      return SignupResult(isSuccess: false, errorMessage: e.toString());
    }
  }
}
