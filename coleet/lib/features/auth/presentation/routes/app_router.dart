import 'package:flutter/material.dart';

import '../../../onboarding/presentation/screens/create_pin_screen.dart';
import '../../../onboarding/presentation/screens/fingerprint_setup_screen.dart';
import '../../../onboarding/presentation/screens/profile_setup_screen.dart';
import '../../../onboarding/presentation/screens/setup_succes_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';

class AppRouter {
  static const String welcomeRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String profileSetupRoute = '/profile-setup';
  static const String createPinRoute = '/create-pin';
  static const String fingerprintSetupRoute = '/fingerprint-setup';
  static const String setupSuccessRoute = '/setup-success';

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