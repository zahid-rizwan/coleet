import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/auth_repository.dart';
import '../bloc/auth_bloc.dart';
import '../routes/app_router.dart';
import '../widgets/social_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back navigation
          },
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to home screen
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful!')),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // App logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.bolt,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "Let's you in",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 40),
                // Social login buttons
                SocialButton(
                  icon: Icons.facebook,
                  text: 'Continue with Facebook',
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      const SocialLoginRequested(SocialLoginType.facebook),
                    );
                  },
                ),
                const SizedBox(height: 16),
                SocialButton(
                  icon: Icons.g_mobiledata,
                  text: 'Continue with Google',
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      const SocialLoginRequested(SocialLoginType.google),
                    );
                  },
                ),
                const SizedBox(height: 16),
                SocialButton(
                  icon: Icons.apple,
                  text: 'Continue with Apple',
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      const SocialLoginRequested(SocialLoginType.apple),
                    );
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.loginRoute);
                  },
                  child: const Text('Sign in with password'),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.registerRoute);
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
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
    );
  }
}