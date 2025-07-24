import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/forgot_password_bloc.dart';
import 'email_text_field.dart';
import 'primary_button.dart';
import '../pages/login_page.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isTablet = MediaQuery.of(context).size.width > 600;
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reset link sent to your email.')),
          );
        } else if (state is ForgotPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        String? errorText;
        String email = '';
        bool isLoading = false;
        bool isSuccess = false;
        if (state is ForgotPasswordInitial) {
          errorText = state.errorText;
          email = state.email;
        } else if (state is ForgotPasswordLoading) {
          isLoading = true;
        } else if (state is ForgotPasswordSuccess) {
          isSuccess = true;
        }
        return Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 120 : 24,
              vertical: isTablet ? 48 : 24,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                color: colorScheme.surfaceVariant.withOpacity(0.7),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Optional: lock/mail icon
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Icon(Icons.lock_reset,
                            size: 56,
                            color: colorScheme.primary.withOpacity(0.7)),
                      ),
                      const Text(
                        'Enter your email to receive a password reset link.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      EmailTextField(
                        controller: _emailController,
                        errorText: errorText,
                        enabled: !isLoading && !isSuccess,
                        onChanged: (value) => context
                            .read<ForgotPasswordBloc>()
                            .add(EmailChanged(value)),
                        autofillHints: const [AutofillHints.email],
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        onPressed: (errorText == null &&
                                _emailController.text.isNotEmpty &&
                                !isLoading &&
                                !isSuccess)
                            ? () {
                                context
                                    .read<ForgotPasswordBloc>()
                                    .add(ForgotPasswordSubmitted());
                              }
                            : null,
                        isLoading: isLoading,
                        enabled: !isSuccess,
                        child: const Text('Send Reset Link'),
                      ),
                      if (isSuccess)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Reset link sent! Check your email.',
                            style: TextStyle(color: colorScheme.primary),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Back to '),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/login');
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
