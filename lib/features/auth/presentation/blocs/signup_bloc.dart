import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';
import '../../domain/usecases/signup_usecase.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUseCase signupUseCase;
  SignupBloc({required this.signupUseCase}) : super(const SignupState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(
          name: event.name, fieldErrors: {...state.fieldErrors, 'name': null}));
    });
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
          email: event.email,
          fieldErrors: {...state.fieldErrors, 'email': null}));
    });
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
          password: event.password,
          fieldErrors: {...state.fieldErrors, 'password': null}));
    });
    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(
          confirmPassword: event.confirmPassword,
          fieldErrors: {...state.fieldErrors, 'confirmPassword': null}));
    });
    on<SignupSubmitted>((event, emit) async {
      final errors = <String, String?>{};
      if (state.name.trim().isEmpty) errors['name'] = 'Name required';
      if (!state.email.contains('@')) errors['email'] = 'Enter a valid email';
      if (state.password.length < 6) errors['password'] = 'Min 6 characters';
      if (!RegExp(r'.*[0-9].*').hasMatch(state.password))
        errors['password'] = 'Must contain a number';
      if (state.confirmPassword != state.password)
        errors['confirmPassword'] = 'Passwords do not match';
      if (errors.isNotEmpty) {
        emit(state.copyWith(fieldErrors: errors));
        return;
      }
      emit(state.copyWith(status: SignupStatus.loading, errorMessage: null));
      try {
        final result = await signupUseCase.call(
          name: state.name,
          email: state.email,
          password: state.password,
        );
        if (result.isSuccess) {
          emit(state.copyWith(status: SignupStatus.success));
        } else {
          emit(state.copyWith(
              status: SignupStatus.failure, errorMessage: result.errorMessage));
        }
      } catch (e) {
        emit(state.copyWith(
            status: SignupStatus.failure, errorMessage: e.toString()));
      }
    });
  }
}
