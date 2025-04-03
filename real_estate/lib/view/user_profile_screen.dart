import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LanguageScreen(),
    );
  }
}

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<LanguageScreen> {
  String selectedLanguage = "English"; // Default language
  List<String> languages = ["Khmer", "English", "Chinese", "Japanese"];

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: languages.map((lang) {
                  return ListTile(
                    title: Text(lang, style: const TextStyle(fontSize: 18)),
                    onTap: () {
                      setState(() {
                        selectedLanguage = lang;
                      });
                      Navigator.pop(context); // Close modal
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 65),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 5),
            ),
            child: const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 95, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          const Text("Keosovann",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          const Text("keosovann168@gmail.com", style: TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 45),
          _buildMenuItem(Icons.person, "User Information"),
          const SizedBox(height: 18),
          _buildLanguageDropdown(), // Language selection
          const SizedBox(height: 18),
          _buildMenuItem(Icons.mail, "Contact"),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(172, 134, 102, 1),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.black, size: 28),
                const SizedBox(width: 20),
                Text(
                  text,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
              IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return GestureDetector(
      onTap: _showLanguageSelector,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.language, color: Colors.black, size: 28),
                  const SizedBox(width: 20),
                  Text(
                    "Language: $selectedLanguage",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Icon(Icons.arrow_drop_down, size: 25, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
} 
