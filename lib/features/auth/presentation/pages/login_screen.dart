import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/login_bloc.dart';
import '../blocs/login_event.dart';
import '../blocs/login_state.dart';
import '../../../../core/service_locator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: const _LoginScreenBody(),
    );
  }
}

class _LoginScreenBody extends StatefulWidget {
  const _LoginScreenBody({super.key});

  @override
  State<_LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<_LoginScreenBody> {
  bool _obscurePassword = true;
  bool _rememberMe = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state.status == LoginStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),

                  // App Bar with Skip button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/home'),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Logo and App Name
                  Center(
                    child: Column(
                      children: [
                        // Logo
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/image.png',
                                width: 60,
                                height: 60,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // App name
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Yene',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            Text(
                              'Gebiya',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4CAF50).withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Discover Fashion That Speaks',
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16), // reduced spacing after logo

                  // Welcome Text
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Sign in to continue your fashion journey',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Email/Phone field
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return TextField(
                        controller: _emailController,
                        onChanged: (value) =>
                            context.read<LoginBloc>().add(EmailChanged(value)),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Color(0xFF4CAF50),
                          ),
                          labelText: 'Email or Phone Number',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.bodySmall?.color,
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
                            borderSide: const BorderSide(
                                color: Color(0xFF4CAF50), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Password field
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(PasswordChanged(value)),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xFF4CAF50),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.bodySmall?.color,
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
                            borderSide: const BorderSide(
                                color: Color(0xFF4CAF50), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  // Remember me and forgot password
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF4CAF50),
                      ),
                      Text(
                        'Remember Me',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/forgot-password'),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Sign In button
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return SizedBox(
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
                          onPressed: state.status == LoginStatus.loading
                              ? null
                              : () {
                                  context
                                      .read<LoginBloc>()
                                      .add(LoginSubmitted());
                                },
                          child: state.status == LoginStatus.loading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : const Text('Sign In'),
                        ),
                      );
                    },
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
                            color: Theme.of(context).textTheme.bodySmall?.color,
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
                  // Sign up link
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/signup'),
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          children: const [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
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
            ),
          ),
        ),
      ),
    );
  }
}
