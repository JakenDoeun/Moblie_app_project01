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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/img/Login-rafiki.png', height: 230), // Add your image asset
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child:Text('Welcome back! Please log in to your account.'),
              ),
            
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 10),
            //password field
            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      value: _rememberMe , onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    ),
                    Text('Remember me'),
                  ],
                ),
                RichText(text: TextSpan(
                  text: 'Forgot Password?',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.pushNamed(context, '/forgotPassword'); 
                  },
                  )
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color(0xff1A1A2E),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home/otp'); 
              },
              child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/register');
              },
              child: Text('Sign Up', style: TextStyle(fontSize: 18, color: Color(0xff1A1A2E), fontWeight: FontWeight.w500),),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 12.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
                    ),
                Text('Or login with'),
                Expanded(child: Container(
                    margin: const EdgeInsets.only(left: 12.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
                    ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook, size: 30, color: Colors.blue,),
                  onPressed: () {},
                ),
                Gap(40),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.google, size: 30, color: Colors.red,),
                  iconSize: 40,
                  onPressed: () {},
                ),
                Gap(40),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.apple, size: 30, color: Colors.black,),
                  iconSize: 40,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
