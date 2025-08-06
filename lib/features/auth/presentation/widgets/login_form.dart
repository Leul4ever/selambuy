import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/login_bloc.dart';
import '../blocs/login_event.dart';
import '../blocs/login_state.dart';
import 'primary_button.dart';
import '../pages/signup_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isTablet = MediaQuery.of(context).size.width > 600;
    return BlocBuilder<LoginBloc, LoginState>(
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
                        // Logo
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Center(
                            child: Image.asset(
                              'assets/logo.png',
                              height: 64,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Icon(
                                  Icons.shopping_bag,
                                  size: 56,
                                  color: colorScheme.primary),
                            ),
                          ),
                        ),
                        // Email
                        TextFormField(
                          initialValue: state.email,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          onChanged: (value) => context
                              .read<LoginBloc>()
                              .add(EmailChanged(value)),
                          validator: (value) =>
                              value != null && value.contains('@')
                                  ? null
                                  : 'Enter a valid email',
                        ),
                        const SizedBox(height: 16),
                        // Password
                        TextFormField(
                          initialValue: state.password,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                          obscureText: _obscurePassword,
                          autofillHints: const [AutofillHints.password],
                          onChanged: (value) => context
                              .read<LoginBloc>()
                              .add(PasswordChanged(value)),
                          validator: (value) =>
                              value != null && value.length >= 6
                                  ? null
                                  : 'Password too short',
                        ),
                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/forgot-password');
                            },
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: const Text('Forgot password?'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Login button
                        PrimaryButton(
                          onPressed: state.status == LoginStatus.loading
                              ? null
                              : () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context
                                        .read<LoginBloc>()
                                        .add(LoginSubmitted());
                                  }
                                },
                          isLoading: state.status == LoginStatus.loading,
                          child: const Text('Login'),
                        ),
                        if (state.status == LoginStatus.failure &&
                            state.errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              state.errorMessage!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
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
                          label: const Text('Continue with Google'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: Theme.of(context).textTheme.titleMedium,
                            side: BorderSide(color: colorScheme.outlineVariant),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            // TODO: Implement Google sign-in
                          },
                        ),
                        const SizedBox(height: 24),
                        // Social media sign-in options
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Google sign in button
                            SizedBox(
                              width: 52,
                              height: 52,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey[300]!),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  // TODO: Implement Google sign-in
                                },
                                child: const Icon(
                                  Icons.g_mobiledata,
                                  size: 24,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            // Facebook sign in button
                            SizedBox(
                              width: 52,
                              height: 52,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey[300]!),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  // TODO: Implement Facebook sign-in
                                },
                                child: const Icon(
                                  Icons.facebook,
                                  size: 24,
                                  color: Color(0xFF1877F2),
                                ),
                              ),
                            ),
                            // Twitter (X) sign in button
                            SizedBox(
                              width: 52,
                              height: 52,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey[300]!),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  // TODO: Implement Twitter sign-in
                                },
                                child: const Icon(
                                  Icons.flutter_dash,
                                  size: 24,
                                  color: Color(0xFF1DA1F2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/signup');
                              },
                              child: Text(
                                'Sign up',
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
