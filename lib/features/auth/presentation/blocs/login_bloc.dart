import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));
      try {
        final result = await loginUseCase.call(
          email: state.email,
          password: state.password,
        );
        if (result.isSuccess) {
          emit(state.copyWith(status: LoginStatus.success));
        } else {
          emit(state.copyWith(
              status: LoginStatus.failure, errorMessage: result.errorMessage));
        }
      } catch (e) {
        emit(state.copyWith(
            status: LoginStatus.failure, errorMessage: e.toString()));
      }
    });
  }
}
