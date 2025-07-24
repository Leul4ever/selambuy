import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/datasources/supabase_auth_datasource.dart';

// Events
abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
  @override
  List<Object?> get props => [];
}

class EmailChanged extends ForgotPasswordEvent {
  final String email;
  const EmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {}

// States
abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  final String email;
  final String? errorText;
  const ForgotPasswordInitial({this.email = '', this.errorText});
  @override
  List<Object?> get props => [email, errorText];
}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String message;
  const ForgotPasswordFailure(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final SupabaseAuthDatasource datasource;
  ForgotPasswordBloc({required this.datasource})
      : super(const ForgotPasswordInitial()) {
    on<EmailChanged>((event, emit) {
      final email = event.email;
      String? error;
      if (email.isEmpty) {
        error = 'Email required';
      } else if (!email.contains('@')) {
        error = 'Enter a valid email';
      }
      emit(ForgotPasswordInitial(email: email, errorText: error));
    });
    on<ForgotPasswordSubmitted>((event, emit) async {
      final currentState = state;
      String email = '';
      if (currentState is ForgotPasswordInitial) {
        email = currentState.email;
        if (email.isEmpty || !email.contains('@')) {
          emit(ForgotPasswordInitial(
              email: email, errorText: 'Enter a valid email'));
          return;
        }
      }
      emit(ForgotPasswordLoading());
      try {
        await datasource.resetPasswordForEmail(email);
        emit(ForgotPasswordSuccess());
      } catch (e) {
        emit(ForgotPasswordFailure(e.toString()));
        emit(ForgotPasswordInitial(email: email, errorText: null));
      }
    });
  }
}
