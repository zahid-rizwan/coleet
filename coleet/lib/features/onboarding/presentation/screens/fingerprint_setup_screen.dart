import 'package:flutter/material.dart';

import '../../../auth/presentation/routes/app_router.dart';

class FingerprintSetupScreen extends StatelessWidget {
  const FingerprintSetupScreen({Key? key}) : super(key: key);

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
      body: SafeArea(
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
              const SizedBox(height: 80),
              // Fingerprint icon
              Icon(
                Icons.fingerprint,
                size: 150,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 80),
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
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.setupSuccessRoute);
                      },
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
                      onPressed: () {
                        // In a real app, this would trigger fingerprint authentication
                        // For demo purposes, we'll just navigate to the success screen
                        Navigator.pushNamed(context, AppRouter.setupSuccessRoute);
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}