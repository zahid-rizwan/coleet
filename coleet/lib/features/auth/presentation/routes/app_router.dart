import 'package:flutter/material.dart';

import '../../../onboarding/presentation/screens/create_pin_screen.dart';
import '../../../onboarding/presentation/screens/fingerprint_setup_screen.dart';
import '../../../onboarding/presentation/screens/profile_setup_screen.dart';
import '../../../onboarding/presentation/screens/setup_succes_screen.dart';
import '../screens/create_password_screen.dart';
import '../screens/opt_verification_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';

import '../screens/forgot_password_screen.dart';

import '../screens/reset_success_screen.dart';

class AppRouter {
  static const String welcomeRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String profileSetupRoute = '/profile-setup';
  static const String createPinRoute = '/create-pin';
  static const String fingerprintSetupRoute = '/fingerprint-setup';
  static const String setupSuccessRoute = '/setup-success';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String otpVerificationRoute = '/otp-verification';
  static const String createNewPasswordRoute = '/create-new-password';
  static const String resetSuccessRoute = '/reset-success';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case profileSetupRoute:
        return MaterialPageRoute(builder: (_) => const ProfileSetupScreen());
      case createPinRoute:
        return MaterialPageRoute(builder: (_) => const CreatePinScreen());
      case fingerprintSetupRoute:
        return MaterialPageRoute(builder: (_) => const FingerprintSetupScreen());
      case setupSuccessRoute:
        return MaterialPageRoute(builder: (_) => const SetupSuccessScreen());
      case forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case otpVerificationRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            contactMethod: args?['contactMethod'] ?? 'phone',
            contactValue: args?['contactValue'] ?? '',
          ),
        );
      case createNewPasswordRoute:
        return MaterialPageRoute(builder: (_) => const CreateNewPasswordScreen());
      case resetSuccessRoute:
        return MaterialPageRoute(builder: (_) => const ResetSuccessScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}