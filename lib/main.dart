import 'package:flutter/material.dart';
import 'package:laundry_customer_app/core/theme/app_theme.dart';
import 'package:laundry_customer_app/features/onboarding/presentations/screens/onboarding_screen.dart';
import 'package:laundry_customer_app/features/auth/presentation/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry Customer App',
      theme: AppTheme.lightTheme,
      home: Builder(
        builder: (ctx) => OnboardingPage(
          onFinish: () {
            Navigator.of(ctx).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
        ),
      ),
    );
  }
}
