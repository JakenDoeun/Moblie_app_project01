import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for input formatters
import 'bottom_navigation_bar.dart'; // Import the custom bottom navigation bar

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected tab index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    // Navigate to the corresponding page
    if (index == 0) {
      Navigator.pushNamed(context, '/home'); // Home page
    } else if (index == 1) {
      Navigator.pushNamed(context, '/wallet'); // Wallet page
    } else if (index == 2) {
      Navigator.pushNamed(context, '/favorites'); // Favorites page
    } else if (index == 3) {
      Navigator.pushNamed(context, '/userinfo/edit'); // Profile page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(color: Color(0xFF322D29), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add your home page content here...
              const Text('Home Page Content'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex, // Pass the selected index
        onItemTapped: _onItemTapped, // Pass the callback
      ),
    );
  }
}
