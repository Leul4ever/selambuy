import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/supabase_auth_datasource.dart';
import '../../application/forgot_password_bloc.dart';
import '../widgets/forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: BlocProvider(
        create: (_) => ForgotPasswordBloc(datasource: SupabaseAuthDatasource()),
        child: const ForgotPasswordForm(),
      ),
    );
  }
}
