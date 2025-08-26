import 'package:flutter/material.dart';
import 'package:laundry_customer_app/features/onboarding/presentations/screens/onboarding_screen.dart';
import 'package:laundry_customer_app/features/auth/presentation/screens/login_screen.dart';

const Color customPrimaryBlue = Color(0xFF0EA5E9);
const Color customMintGreen = Color(0xFF10B981);
const Color customWhite = Color(0xFFFFFFFF);
const Color textPlaceholder = Color(0xFF374151);
const Color textSubheading = Color(0xFF6B7280);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: customWhite,
        colorScheme: const ColorScheme.light(
          primary: customPrimaryBlue,
          onPrimary: Colors.white,
          secondary: customMintGreen,
          onSecondary: Colors.white,
          background: customWhite,
          onBackground: Colors.black,
        ),
      ),
      // Start with onboarding, and after finishing, go to LoginPage.
      home: Builder(
        builder: (ctx) => OnboardingPage(
          onFinish: () {
            // Ubah navigasi dari MyHomePage ke LoginPage
            Navigator.of(ctx).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
        ),
      ),
    );
  }
}
