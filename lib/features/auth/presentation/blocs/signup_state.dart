import 'package:equatable/equatable.dart';

enum SignupStatus { initial, loading, success, failure }

class SignupState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final SignupStatus status;
  final String? errorMessage;
  final Map<String, String?> fieldErrors;

  const SignupState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.status = SignupStatus.initial,
    this.errorMessage,
    this.fieldErrors = const {},
  });

  SignupState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    SignupStatus? status,
    String? errorMessage,
    Map<String, String?>? fieldErrors,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      errorMessage: errorMessage,
      fieldErrors: fieldErrors ?? this.fieldErrors,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        confirmPassword,
        status,
        errorMessage,
        fieldErrors
      ];
}
