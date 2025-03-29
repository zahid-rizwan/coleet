import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../auth/presentation/routes/app_router.dart';


class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({Key? key}) : super(key: key);

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final List<String?> _pin = List.filled(4, null);
  int _currentIndex = 0;

  void _addDigit(String digit) {
    if (_currentIndex < _pin.length) {
      setState(() {
        _pin[_currentIndex] = digit;
        _currentIndex++;
      });

      // If PIN is complete, wait a moment and then proceed
      if (_currentIndex == _pin.length) {
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushNamed(context, AppRouter.fingerprintSetupRoute);
        });
      }
    }
  }

  void _removeDigit() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _pin[_currentIndex] = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New PIN', style: TextStyle(color: Colors.black)),
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
                'Add a PIN number to make your account more secure.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 60),
              // PIN input display
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pin.length,
                      (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: index == _currentIndex
                          ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: _pin[index] != null
                          ? index == _currentIndex - 1
                          ? Text(
                        _pin[index]!,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      )
                          : Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // Continue button
              ElevatedButton(
                onPressed: _currentIndex == _pin.length
                    ? () {
                  Navigator.pushNamed(context, AppRouter.fingerprintSetupRoute);
                }
                    : null,
                child: const Text('Continue'),
              ),
              const Spacer(),
              // Number pad
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                children: [
                  ...[1, 2, 3, 4, 5, 6, 7, 8, 9].map((digit) => _buildNumberKey(digit.toString())),
                  _buildNumberKey('*'),
                  _buildNumberKey('0'),
                  _buildBackspaceKey(),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberKey(String digit) {
    return InkWell(
      onTap: () => _addDigit(digit),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            digit,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceKey() {
    return InkWell(
      onTap: _removeDigit,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Icon(Icons.backspace_outlined, size: 24),
        ),
      ),
    );
  }
}