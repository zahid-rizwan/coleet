import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../routes/app_router.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String contactMethod;
  final String contactValue;

  const OtpVerificationScreen({
    Key? key,
    required this.contactMethod,
    required this.contactValue,
  }) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<String?> _otp = List.filled(4, null);
  int _currentIndex = 0;
  int _resendSeconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() {
          _resendSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _addDigit(String digit) {
    if (_currentIndex < _otp.length) {
      setState(() {
        _otp[_currentIndex] = digit;
        _currentIndex++;
      });

      // If OTP is complete, wait a moment and then proceed
      if (_currentIndex == _otp.length) {
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushNamed(context, AppRouter.createNewPasswordRoute);
        });
      }
    }
  }

  void _removeDigit() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _otp[_currentIndex] = null;
      });
    }
  }

  void _resendCode() {
    if (_resendSeconds == 0) {
      // In a real app, this would trigger the OTP resend
      setState(() {
        _resendSeconds = 60;
      });
      _startResendTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Code Verification', style: TextStyle(color: Colors.black)),
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
              const SizedBox(height: 60),
              Text(
                'Code has been send to ${widget.contactValue}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 60),
              // OTP input display
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _otp.length,
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
                      child: _otp[index] != null
                          ? Text(
                        _otp[index]!,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      )
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Resend code
              GestureDetector(
                onTap: _resendCode,
                child: RichText(
                  text: TextSpan(
                    text: 'Resend code in ',
                    style: const TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(
                        text: '$_resendSeconds',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: ' s'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // Verify button
              ElevatedButton(
                onPressed: _currentIndex == _otp.length
                    ? () {
                  Navigator.pushNamed(context, AppRouter.createNewPasswordRoute);
                }
                    : null,
                child: const Text('Verify'),
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