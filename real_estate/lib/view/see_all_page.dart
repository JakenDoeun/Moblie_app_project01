import 'package:flutter/material.dart';
import 'property_detail.dart';

class SeeAllPage extends StatelessWidget {
  final List<Map<String, dynamic>> properties;

  const SeeAllPage({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Properties'),
        backgroundColor: const Color(0xFF322D29),
      ),
      body: ListView.builder(
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PropertyDetailPage(
                    mainImage: property['image'] as String,
                    roomImages: [
                      'assets/images/room1.jpg',
                      'assets/images/room2.jpg',
                      'assets/images/room3.jpg',
                      'assets/images/room4.jpg',
                    ],
                    title: property['title'] as String,
                    price: property['price'] as String,
                    location: property['location'] as String,
                    description: property['description'] as String,
                    specifications: property['specifications'] as List<String>,
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      property['image'] as String,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 50),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property['title'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          property['location'] as String,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          property['price'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
