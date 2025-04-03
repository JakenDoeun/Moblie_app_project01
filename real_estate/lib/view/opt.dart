import 'package:flutter/material.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final int codeLength = 5;
  final List<TextEditingController> controllers = [];
  final List<FocusNode> focusNodes = [];
  bool hasInput = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each digit
    for (int i = 0; i < codeLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
    node.dispose();
    }
    super.dispose();
  }

  // Check if any of the input fields have text
  void checkInput() {
    bool input = false;
    for (var controller in controllers) {
      if (controller.text.isNotEmpty) {
        input = true;
        break;
      }
    }
    
    if (input != hasInput) {
      setState(() {
        hasInput = input;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Check your email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                children: [
                  const TextSpan(text: 'We sent a reset link to '),
                  TextSpan(
                    text: 'Okane123@yahoo.com',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'enter 5 digit code that mentioned in the email',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                codeLength,
                (index) => SizedBox(
                  width: 56,
                  height: 56,
                  child: TextField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    showCursor: true,
                    onTap: () {
                      // Automatically focus the first empty box
                      for (int i = 0; i < codeLength; i++) {
                        if (controllers[i].text.isEmpty) {
                          FocusScope.of(context).requestFocus(focusNodes[i]);
                          break;
                        }
                      }
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty && index < codeLength - 1) {
                        // Move to the next box
                        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                      } else if (value.isEmpty && index > 0) {
                        // Move back to the previous box if the current box is cleared
                        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                      }
                      checkInput(); // Check if any input is present
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasInput ? Color(0xff1A1A2E) : Colors.grey[300],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Verify Code',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Haven't got the email yet? ",
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    // Resend email logic
                  },
                  child: const Text(
                    'Resend email',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}