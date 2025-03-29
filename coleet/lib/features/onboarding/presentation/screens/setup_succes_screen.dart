import 'package:flutter/material.dart';

import '../../../auth/presentation/routes/app_router.dart';

class SetupSuccessScreen extends StatefulWidget {
  const SetupSuccessScreen({Key? key}) : super(key: key);

  @override
  State<SetupSuccessScreen> createState() => _SetupSuccessScreenState();
}

class _SetupSuccessScreenState extends State<SetupSuccessScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-navigate to home after a delay
    Future.delayed(const Duration(seconds: 3), () {
      // In a real app, you would navigate to the home screen
      // For demo purposes, we'll go back to the welcome screen
      Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouter.welcomeRoute,
              (route) => false
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Your Fingerprint', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background content (fingerprint screen)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Add a fingerprint to make your account more secure.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Please put your finger on the fingerprint scanner to get started.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: null,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            side: BorderSide.none,
                          ),
                          child: const Text('Skip'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: null,
                          child: const Text('Continue'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Success modal overlay
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Congratulations!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your account is ready to use. You will be redirected to the Home page in a few seconds.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}