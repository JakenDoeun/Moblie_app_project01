import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter/gestures.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool _rememberMe = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _usernameError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('lib/img/Login-rafiki.png', height: 230), // Add your image asset
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text('Welcome back! Please log in to your account.'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  errorText: _usernameError,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  errorText: _passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      const Text('Remember me'),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Forgot Password?',
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/forgotPassword');
                        },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xff1A1A2E),
                ),
                onPressed: () {
                  setState(() {
                    _usernameError = _usernameController.text.isEmpty ? 'Username is required' : null;
                    _passwordError = _passwordController.text.isEmpty ? 'Password is required' : null;
                  });

                  if (_usernameError == null && _passwordError == null) {
                    // Navigate to the home screen if validation passes
                    Navigator.pushNamed(context, '/otp');
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/register');
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff1A1A2E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                      indent: 10,
                      endIndent: 12,
                    ),
                  ),
                  const Text('Or login with'),
                  const Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                      indent: 12,
                      endIndent: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebook, size: 30, color: Colors.blue),
                    onPressed: () {},
                  ),
                  const Gap(40),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.google, size: 30, color: Colors.red),
                    onPressed: () {},
                  ),
                  const Gap(40),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.apple, size: 30, color: Colors.black),
                    onPressed: () {},
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
