import 'package:flutter/material.dart';
import 'package:real_estate/view/indexfile.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Estate App',
      initialRoute: '/propertyDetails',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(),
        '/register': (context) => const SignUpScreen(),
        '/home/otp': (context) => const VerificationCodeScreen(),
        '/forgotPassword': (context) => const ForgotPasswordScreen(),
        '/propertyDetails': (context) => const PropertyDetailPage(),
      },
    );
  }
}
