import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/signup_form.dart';
import '../../data/datasources/supabase_auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../blocs/signup_bloc.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: BlocProvider(
        create: (_) => SignupBloc(
          signupUseCase: SignupUseCase(
            AuthRepositoryImpl(
              SupabaseAuthDatasource(),
            ),
          ),
        ),
        child: const SignupForm(),
      ),
    );
  }
}
