import 'package:flutter/material.dart';
import 'example_widget.dart';

class FilteredPropertiesScreen extends StatefulWidget {
  final List<Property> properties;

  const FilteredPropertiesScreen({Key? key, required this.properties})
      : super(key: key);

  @override
  _FilteredPropertiesScreenState createState() =>
      _FilteredPropertiesScreenState();
}

class _FilteredPropertiesScreenState extends State<FilteredPropertiesScreen> {
  String filterKeyword = '';
  List<Property> filteredProperties = [];

  @override
  void initState() {
    super.initState();
    filteredProperties = widget.properties; // Initially show all properties
  }

  void filterProperties(String keyword) {
    setState(() {
      filterKeyword = keyword.toLowerCase();
      filteredProperties = widget.properties
          .where((property) =>
              property.title.toLowerCase().contains(filterKeyword) ||
              property.location.toLowerCase().contains(filterKeyword) ||
              property.description.toLowerCase().contains(filterKeyword) ||
              _isSimilar(property, filterKeyword))
          .toList();
    });
  }

  bool _isSimilar(Property property, String keyword) {
    // Check for partial matches or similar properties
    final keywords = keyword.split(' ');
    return keywords.any((word) =>
        property.title.toLowerCase().contains(word) ||
        property.location.toLowerCase().contains(word) ||
        property.description.toLowerCase().contains(word));
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
              onChanged: (value) {
                filterProperties(value); // Trigger filtering on text change
              },
            ),
          ),
          Expanded(
            child: filteredProperties.isEmpty
                ? Center(
                    child: Text(
                      'No properties found.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
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
