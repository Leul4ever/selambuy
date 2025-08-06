import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/signup_bloc.dart';
import '../blocs/signup_event.dart';
import '../blocs/signup_state.dart';
import 'primary_button.dart';
import 'password_strength_indicator.dart';

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
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _showPasswordRules = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
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
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              // Name field
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF4CAF50),
                  ),
                  labelText: 'Full Name',
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Color(0xFF4CAF50), width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  errorText: state.fieldErrors['name'],
                ),
                autofillHints: const [AutofillHints.name],
                onChanged: (value) =>
                    context.read<SignupBloc>().add(NameChanged(value)),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_emailFocus),
              ),
              const SizedBox(height: 16),
              // Email field
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xFF4CAF50),
                  ),
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Color(0xFF4CAF50), width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  errorText: state.fieldErrors['email'],
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                onChanged: (value) =>
                    context.read<SignupBloc>().add(EmailChanged(value)),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_passwordFocus),
              ),
              const SizedBox(height: 16),
              // Password field
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF4CAF50),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Color(0xFF4CAF50), width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  errorText: state.fieldErrors['password'],
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                obscureText: _obscurePassword,
                autofillHints: const [AutofillHints.newPassword],
                onChanged: (value) {
                  context.read<SignupBloc>().add(PasswordChanged(value));
                  setState(() {});
                },
                onTap: () => setState(() => _showPasswordRules = true),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_confirmPasswordFocus),
              ),
              const SizedBox(height: 8),
              PasswordStrengthIndicator(password: _passwordController.text),
              _passwordRules(context),
              const SizedBox(height: 16),
              // Confirm Password field
              TextFormField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocus,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF4CAF50),
                  ),
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Color(0xFF4CAF50), width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  errorText: state.fieldErrors['confirmPassword'],
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () => setState(() =>
                        _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                ),
                obscureText: _obscureConfirmPassword,
                autofillHints: const [AutofillHints.newPassword],
                onChanged: (value) => context
                    .read<SignupBloc>()
                    .add(ConfirmPasswordChanged(value)),
              ),
              const SizedBox(height: 24),
              // Create Account button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  onPressed: state.status == SignupStatus.loading
                      ? null
                      : () {
                          context.read<SignupBloc>().add(SignupSubmitted());
                        },
                  child: state.status == SignupStatus.loading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text('Signup'),
                ),
              ),
              const SizedBox(height: 20),
              // Divider with or
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                        Icons.close,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Sign in link
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/login'),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: const TextStyle(
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
