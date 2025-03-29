import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/routes/app_router.dart';


class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  String _phoneNumber = '';
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    // Pre-fill email if available from auth state
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      _emailController.text = authState.user.email;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.month}/${picked.day}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill Your Profile', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile image
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: _profileImagePath != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset(
                            _profileImagePath!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                            onPressed: () {
                              // Handle image selection
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Full Name
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      hintText: 'Full Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Nickname
                  TextFormField(
                    controller: _nicknameController,
                    decoration: const InputDecoration(
                      hintText: 'Nickname',
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Date of Birth
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'Date of Birth',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 16),
                  // Email
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      suffixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Phone Number
                  IntlPhoneField(
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                    ),
                    initialCountryCode: 'US',
                    onChanged: (phone) {
                      _phoneNumber = phone.completeNumber;
                    },
                  ),
                  const SizedBox(height: 32),
                  // Continue Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save profile data
                        // In a real app, you would dispatch an event to the ProfileBloc
                        Navigator.pushNamed(context, AppRouter.createPinRoute);
                      }
                    },
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}