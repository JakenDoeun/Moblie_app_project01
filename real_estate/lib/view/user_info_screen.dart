import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart'; // Import the new file



class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'User Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Profile Avatar with Camera Icon
          Stack(
            alignment: Alignment.center,
            children: [
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
              Positioned(
                top: 4,
                right: 0,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.camera_alt, color: Colors.white, size: 15),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // User Info Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                  ),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Edit',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {},
                  ),
                  _buildInfoTile(Icons.person, "User Information"),
                  _buildInfoTile(Icons.location_on, "Location"),
                  _buildInfoTile(Icons.email, "Email Address"),
                  _buildInfoTile(Icons.phone, "Phone Number"),
                  _buildInfoTile(Icons.calendar_today, "Day of Birth"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      child: InkWell( 
        onTap: () {
          
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.black, size: 28),
                  const SizedBox(width: 18),
                  Padding(padding: const EdgeInsets.only(left: 12)),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }  
}
