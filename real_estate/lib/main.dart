import 'package:flutter/material.dart';
import 'view/indexfile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Set as the entry point
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const SignUpScreen(),
        '/home': (context) => const HomePage(),
        '/otp': (context) => const VerificationCodeScreen(),
        '/forgotPassword': (context) => const ForgotPasswordScreen(),
        '/contact': (context) => const ContactScreen(),
      },
    );
  }
}
