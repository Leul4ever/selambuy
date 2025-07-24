import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/signup_bloc.dart';
import '../blocs/signup_event.dart';
import '../blocs/signup_state.dart';
import 'input_field.dart';
import 'primary_button.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _showPasswordRules = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _passwordRules(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedOpacity(
      opacity: _showPasswordRules ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: _showPasswordRules
          ? Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.check, size: 16, color: colorScheme.primary),
                    const SizedBox(width: 8),
                    const Text('At least 6 characters'),
                  ]),
                  const SizedBox(height: 4),
                  Row(children: [
                    Icon(Icons.check, size: 16, color: colorScheme.primary),
                    const SizedBox(width: 8),
                    const Text('Contains a number'),
                  ]),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isTablet = MediaQuery.of(context).size.width > 600;
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
        if (state.status == SignupStatus.success) {
          // TODO: Navigate to home
        }
      },
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 120 : 24,
              vertical: isTablet ? 48 : 24,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Name
                        InputField(
                          label: 'Full Name',
                          controller: _nameController,
                          prefixIcon: const Icon(Icons.person_outline),
                          errorText: state.fieldErrors['name'],
                          onChanged: (value) => context
                              .read<SignupBloc>()
                              .add(NameChanged(value)),
                          autofillHints: const [AutofillHints.name],
                        ),
                        const SizedBox(height: 16),
                        // Email
                        InputField(
                          label: 'Email',
                          controller: _emailController,
                          prefixIcon: const Icon(Icons.email_outlined),
                          errorText: state.fieldErrors['email'],
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => context
                              .read<SignupBloc>()
                              .add(EmailChanged(value)),
                          autofillHints: const [AutofillHints.email],
                        ),
                        const SizedBox(height: 16),
                        // Password
                        InputField(
                          label: 'Password',
                          controller: _passwordController,
                          prefixIcon: const Icon(Icons.lock_outline),
                          errorText: state.fieldErrors['password'],
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword),
                          ),
                          onChanged: (value) => context
                              .read<SignupBloc>()
                              .add(PasswordChanged(value)),
                          autofillHints: const [AutofillHints.newPassword],
                          onTap: () =>
                              setState(() => _showPasswordRules = true),
                          focusNode: FocusNode()
                            ..addListener(() {
                              setState(() => _showPasswordRules =
                                  _passwordController.selection.baseOffset !=
                                      -1);
                            }),
                        ),
                        _passwordRules(context),
                        // Confirm Password
                        InputField(
                          label: 'Confirm Password',
                          controller: _confirmPasswordController,
                          prefixIcon: const Icon(Icons.lock_outline),
                          errorText: state.fieldErrors['confirmPassword'],
                          obscureText: _obscureConfirmPassword,
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => setState(() =>
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword),
                          ),
                          onChanged: (value) => context
                              .read<SignupBloc>()
                              .add(ConfirmPasswordChanged(value)),
                          autofillHints: const [AutofillHints.newPassword],
                        ),
                        const SizedBox(height: 24),
                        // Create Account button
                        PrimaryButton(
                          onPressed: state.status == SignupStatus.loading
                              ? null
                              : () {
                                  context
                                      .read<SignupBloc>()
                                      .add(SignupSubmitted());
                                },
                          isLoading: state.status == SignupStatus.loading,
                          child: const Text('Create Account'),
                        ),
                        const SizedBox(height: 24),
                        // Divider with OR
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text('OR',
                                  style: TextStyle(
                                      color: colorScheme.onSurfaceVariant)),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Google button
                        OutlinedButton.icon(
                          icon: Image.asset(
                            'assets/google_logo.png',
                            height: 20,
                            width: 20,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.g_mobiledata, size: 24),
                          ),
                          label: const Text('Sign up with Google'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: Theme.of(context).textTheme.titleMedium,
                            side: BorderSide(color: colorScheme.outlineVariant),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            // TODO: Implement Google sign-up
                          },
                        ),
                        const SizedBox(height: 24),
                        // Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account? '),
                            GestureDetector(
                              onTap: () {
                                // TODO: Navigate to login
                              },
                              child: Text(
                                'Log in',
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
          ),
        );
      },
    );
  }
}
