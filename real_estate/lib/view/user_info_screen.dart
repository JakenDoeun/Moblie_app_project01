import 'package:flutter/material.dart';
// Import the new file



class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
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
              ],
            ),
            const SizedBox(height: 10),
            const Text("Keosovann",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const Text("keosovann168@gmail.com", style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/editInfo'); // Navigate to EditInfo screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
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
                    _buildTitle("User Name"),
                    _buildInfoTile(Icons.person, "Keosovann"),
                    _buildTitle("Location"),
                    _buildInfoTile(Icons.location_on, "#061, Khan Mean Chey"),
                    _buildTitle("Email"),
                    _buildInfoTile(Icons.email, "keosovann168@gmail.com"),
                    _buildTitle("Phone Number"),
                    _buildInfoTile(Icons.phone, "092 996 630"),
                    _buildTitle("Date of Birth"),
                    _buildInfoTile(Icons.calendar_today, "04 April 2005"),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 20,)
          ],
        ),
        
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 5), // Add bottom padding for spacing
      child: Align(
        alignment: Alignment.centerLeft, // Align the title to the left
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      child: InkWell(
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
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
