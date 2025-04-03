import 'package:flutter/material.dart';

class Property {
  final String imagePath;
  final String title;
  final String location;
  final String price;
  final String description; // New field for property description

  Property({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.price,
    required this.description,
  });
}

class PropertyListScreen extends StatefulWidget {
  @override
  _PropertyListScreenState createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  final List<Property> properties = [
    Property(
      imagePath: 'assets/image/Image1.jpg',
      title: 'Modern Apartment',
      location: 'Downtown City Center',
      price: '\$1,200/month',
      description:
          'A stylish modern apartment with 2 bedrooms and 2 bathrooms.',
    ),
    Property(
      imagePath: 'assets/image/Image2.jpg',
      title: 'Cozy Condo',
      location: 'Quiet Suburban Area',
      price: '\$800/month',
      description: 'A cozy 1-bedroom condo perfect for singles or couples.',
    ),
    Property(
      imagePath: 'assets/image/Image3.jpg',
      title: 'Luxury Villa',
      location: 'Beachside Paradise',
      price: '\$2,500/month',
      description: 'A luxurious villa with a private pool and ocean views.',
    ),
    Property(
      imagePath: 'assets/image/Image4.jpg',
      title: 'Spacious House',
      location: 'Countryside Retreat',
      price: '\$1,500/month',
      description: 'A spacious 4-bedroom house with a large garden.',
    ),
  ];

  final List<String> assetImages = [
    'assets/image/Image1.jpg',
    'assets/image/Image2.jpg',
    'assets/image/Image3.jpg',
    'assets/image/Image4.jpg',
    'assets/image/Image5.jpg',
    'assets/image/Image6.jpg',
    'assets/image/Image7.jpg',
    'assets/image/Condo1.jpg',
    'assets/image/Condo2.jpg',
    'assets/image/Condo3.jpg',
    'assets/image/property_main.jpg',
    'assets/image/room1.jpg',
    'assets/image/room2.jpg',
    'assets/image/room3.jpg',
    'assets/image/room4.jpg',
  ];

  String selectedImage = 'assets/image/Image1.jpg';

  void navigateToFilteredProperties() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilteredPropertiesScreen(properties: properties),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Properties',
          style: TextStyle(color: Colors.white), // Ensure title is visible
        ),
        iconTheme:
            IconThemeData(color: Colors.white), // Ensure back icon is visible
        backgroundColor: Colors.blue, // Set AppBar background color
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: navigateToFilteredProperties,
            child: Text('Filter Properties'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final property = properties[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        property.imagePath,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/image/placeholder.jpg',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    title: Text(
                      property.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Ensure title text is visible
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.location,
                          style: TextStyle(
                              color: Colors.grey), // Ensure subtitle is visible
                        ),
                        SizedBox(height: 5),
                        Text(
                          property.description,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12), // Ensure description is visible
                        ),
                      ],
                    ),
                    trailing: Text(
                      property.price,
                      style: TextStyle(
                        color: Colors.green, // Ensure price text is visible
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilteredPropertiesScreen extends StatefulWidget {
  final List<Property> properties;

  FilteredPropertiesScreen({required this.properties});

  @override
  _FilteredPropertiesScreenState createState() =>
      _FilteredPropertiesScreenState();
}

class _FilteredPropertiesScreenState extends State<FilteredPropertiesScreen> {
  List<Property> filteredProperties = [];
  String filterKeyword = '';

  @override
  void initState() {
    super.initState();
    filteredProperties = widget.properties;
  }

  void filterProperties(String keyword) {
    setState(() {
      filterKeyword = keyword;
      filteredProperties = widget.properties
          .where((property) =>
              property.title.toLowerCase().contains(keyword.toLowerCase()) ||
              property.location.toLowerCase().contains(keyword.toLowerCase()) ||
              property.description
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtered Properties'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Properties',
                border: OutlineInputBorder(),
              ),
              onChanged: filterProperties,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                final property = filteredProperties[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        property.imagePath,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/image/placeholder.jpg',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    title: Text(
                      property.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.location,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(
                          property.description,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      property.price,
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
