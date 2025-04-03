import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for input formatters
import 'package:real_estate/view/indexfile.dart';// Import the new page
import 'package:real_estate/view/property_details.dart'; // Import the detail page



class ResultsPageStateful extends StatefulWidget {
  const ResultsPageStateful({super.key});

  @override
  State<ResultsPageStateful> createState() => _ResultsPageStateful();
}

class _ResultsPageStateful extends State<ResultsPageStateful> {
  bool isBuySelected = true; // Manage state at the widget level
  String selectedFilter = 'ALL'; // Add state for selected filter
  // List of filter options
  final List<String> filterOptions = ['ALL', 'Apartment/Condos', 'Villa', 'Studio'];
  // Map to track selected state for each filter
  late Map<String, bool> selectedFilters;

  @override
  void initState() {
    super.initState();
    // Initialize "ALL" as selected and others as unselected
    selectedFilters = {
      for (var option in filterOptions) option: option == 'ALL',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Color(0xFF322D29), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white), // Changed icon
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Search Bar
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search property',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Add the provided icon as a button
                  IconButton(
                    icon: Icon(Icons.tune, color: Colors.grey), // Added icon
                    iconSize: 24, // Adjust size as needed
                    onPressed: () {
                      bool isBuySelected = true; // Move state initialization outside the builder
                      String? selectedLocation;
                      String? budgetMin;
                      String? budgetMax;
                      String? area;
                      String? bedrooms;
                      String? rentDuration;
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        isScrollControlled: true, // Allow the bottom sheet to extend its height
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              bool isFormValid() {
                                if (isBuySelected) {
                                  return selectedLocation != null &&
                                      selectedLocation?.isNotEmpty == true &&
                                      budgetMin != null &&
                                      budgetMin?.isNotEmpty == true &&
                                      budgetMax != null &&
                                      budgetMax?.isNotEmpty == true &&
                                      area != null &&
                                      area?.isNotEmpty == true &&
                                      bedrooms != null &&
                                      bedrooms?.isNotEmpty == true;
                                } else {
                                  return selectedLocation != null &&
                                      selectedLocation?.isNotEmpty == true &&
                                      area != null &&
                                      area?.isNotEmpty == true &&
                                      bedrooms != null &&
                                      bedrooms?.isNotEmpty == true &&
                                      rentDuration != null &&
                                      rentDuration?.isNotEmpty == true;
                                }
                              }

                              return DraggableScrollableSheet(
                                initialChildSize: 0.8, // Set the initial height as a fraction of the screen height
                                minChildSize: 0.4, // Set the minimum height
                                maxChildSize: 1, // Set the maximum height
                                expand: false, // Allow the sheet to be draggable
                                builder: (context, scrollController) {
                                  return SingleChildScrollView(
                                    controller: scrollController, // Attach the scroll controller
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Choose property',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ChoiceChip(
                                                label: Text('Buy'),
                                                selected: isBuySelected,
                                                selectedColor: Color(0xFF322D29),
                                                labelStyle: TextStyle(
                                                  color: isBuySelected ? Colors.white : Colors.black,
                                                ),
                                                onSelected: (bool selected) {
                                                  setState(() {
                                                    isBuySelected = true;
                                                  });
                                                },
                                                showCheckmark: false,
                                              ),
                                              ChoiceChip(
                                                label: Text('Rent'),
                                                selected: !isBuySelected,
                                                selectedColor: Color(0xFF322D29),
                                                labelStyle: TextStyle(
                                                  color: !isBuySelected ? Colors.white : Colors.black,
                                                ),
                                                onSelected: (bool selected) {
                                                  setState(() {
                                                    isBuySelected = false;
                                                  });
                                                },
                                                showCheckmark: false,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                          if (isBuySelected)
                                            // Buy Part
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Wrap(
                                                  spacing: 8,
                                                  runSpacing: 8,
                                                  children: [
                                                    FilterChipWidgetF(label: 'Townhouse'),
                                                    FilterChipWidgetF(label: 'Apartment'),
                                                    FilterChipWidgetF(label: 'Flat'),
                                                    FilterChipWidgetF(label: 'Villa'),
                                                    FilterChipWidgetF(label: 'Borey'),
                                                    FilterChipWidgetF(label: 'Commercial Plot'),
                                                  ],
                                                ),
                                                SizedBox(height: 16),
                                                DropdownButtonFormField<String>(
                                                  decoration: InputDecoration(
                                                    labelText: 'Choose Location',
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  items: [
                                                    'Phnom Penh',
                                                    'Siem Reap',
                                                    'Battambang',
                                                    'Sihanoukville',
                                                    'Kampong Cham',
                                                    'Kampot',
                                                    'Takeo',
                                                    'Kandal',
                                                    'Prey Veng',
                                                    'Svay Rieng',
                                                    'Pursat',
                                                    'Koh Kong',
                                                    'Ratanakiri',
                                                    'Mondulkiri',
                                                    'Stung Treng',
                                                    'Kratie',
                                                    'Oddar Meanchey',
                                                    'Banteay Meanchey',
                                                    'Pailin',
                                                    'Kampong Thom',
                                                    'Kampong Speu',
                                                    'Kampong Chhnang',
                                                    'Preah Vihear',
                                                    'Tbong Khmum',
                                                    'Kep',
                                                  ].map((String location) {
                                                    return DropdownMenuItem<String>(
                                                      value: location,
                                                      child: Text(location),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      selectedLocation = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 16),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextField(
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.digitsOnly
                                                        ],
                                                        decoration: InputDecoration(
                                                          labelText: 'Start Range\$',
                                                          border: OutlineInputBorder(),
                                                        ),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            budgetMin = value;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text('-'),
                                                    SizedBox(width: 8),
                                                    Expanded(
                                                      child: TextField(
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.digitsOnly
                                                        ],
                                                        decoration: InputDecoration(
                                                          labelText: 'End Range\$',
                                                          border: OutlineInputBorder(),
                                                        ),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            budgetMax = value;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 16),
                                                TextField(
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  decoration: InputDecoration(
                                                    labelText: 'Insert Area',
                                                    hintText: 'In Meter Square',
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      area = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 16),
                                                TextField(
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  decoration: InputDecoration(
                                                    labelText: 'Insert the bedroom',
                                                    hintText: '1 - 5+',
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      bedrooms = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            )
                                          else
                                            // Rent Part
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Wrap(
                                                  spacing: 8,
                                                  runSpacing: 8,
                                                  children: [
                                                    FilterChipWidgetF(label: 'Studio'),
                                                    FilterChipWidgetF(label: 'Apartment'),
                                                    FilterChipWidgetF(label: 'Villa'),
                                                    FilterChipWidgetF(label: 'Flat'),
                                                    FilterChipWidgetF(label: 'Borey'),
                                                  ],
                                                ),
                                                SizedBox(height: 16),
                                                DropdownButtonFormField<String>(
                                                  decoration: InputDecoration(
                                                    labelText: 'Choose Location',
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  items: [
                                                    'Phnom Penh',
                                                    'Siem Reap',
                                                    'Battambang',
                                                    'Sihanoukville',
                                                    'Kampong Cham',
                                                    'Kampot',
                                                    'Takeo',
                                                    'Kandal',
                                                    'Prey Veng',
                                                    'Svay Rieng',
                                                    'Pursat',
                                                    'Koh Kong',
                                                    'Ratanakiri',
                                                    'Mondulkiri',
                                                    'Stung Treng',
                                                    'Kratie',
                                                    'Oddar Meanchey',
                                                    'Banteay Meanchey',
                                                    'Pailin',
                                                    'Kampong Thom',
                                                    'Kampong Speu',
                                                    'Kampong Chhnang',
                                                    'Preah Vihear',
                                                    'Tbong Khmum',
                                                    'Kep',
                                                  ].map((String location) {
                                                    return DropdownMenuItem<String>(
                                                      value: location,
                                                      child: Text(location),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      selectedLocation = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 16),
                                                TextField(
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  decoration: InputDecoration(
                                                    labelText: 'Insert Area',
                                                    hintText: 'In Meter Square',
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      area = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 16),
                                                TextField(
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  decoration: InputDecoration(
                                                    labelText: 'Insert the bedroom',
                                                    hintText: '1 - 5+',
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      bedrooms = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 16),
                                                TextField(
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  decoration: InputDecoration(
                                                    labelText: 'Rent for',
                                                    hintText: '1 - 10 year+',
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      rentDuration = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: isFormValid()
                                                ? () {
                                                    Navigator.pop(context); // Close the modal
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => ResultsPage(
                                                          filters: {
                                                            'isBuySelected': isBuySelected,
                                                            'selectedLocation': selectedLocation,
                                                            'budgetMin': budgetMin,
                                                            'budgetMax': budgetMax,
                                                            'area': area,
                                                            'bedrooms': bedrooms,
                                                            'rentDuration': rentDuration,
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: isFormValid()
                                                  ? Color(0xFF322D29)
                                                  : Colors.grey[400],
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Filter',
                                                style: TextStyle(
                                                  color: isFormValid()
                                                      ? Colors.white
                                                      : Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Filter Buttons
              SizedBox(
                height: 50, // Set a fixed height for the ListView
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                  itemCount: filterOptions.length, // Number of filter options
                  itemBuilder: (context, index) {
                    final option = filterOptions[index]; // Current filter option
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0), // Add spacing between chips
                      child: FilterChip(
                        label: Text(option),
                        selected: selectedFilters[option]!, // Check if this chip is selected
                        selectedColor: Color(0xFF322D29), // Highlight color for selected chip
                        backgroundColor: Colors.grey[200], // Background color for unselected chips
                        labelStyle: TextStyle(
                          color: selectedFilters[option]! ? Colors.white : Colors.black, // Text color
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), // Rounded corners
                        ),
                        showCheckmark: false, // Hide the checkmark icon
                        onSelected: (bool selected) {
                          setState(() {
                            // Ensure only one chip is selected at a time
                            selectedFilters.updateAll((key, value) => false); // Deselect all chips
                            selectedFilters[option] = true; // Select the clicked chip
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              // Recommended Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommend For You',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      final allProperties = [
                        {
                          'image': 'assets/image/Image1.jpg',
                          'title': 'The Mekong Garden',
                          'price': '\$750,000',
                          'location': 'Khan Chamkar Mon, Phnom Penh',
                          'bedrooms': 5,
                          'bathrooms': 4,
                          'area': '320 sqm',
                          'description':
                              'A luxurious garden property with modern amenities.',
                          'specifications': [
                            '5 bedrooms with en-suite bathrooms',
                            'Large garden and swimming pool',
                            'Modern kitchen with high-end appliances',
                            'Spacious living and dining areas',
                          ],
                        },
                        {
                          'image': 'assets/image/Image2.jpg',
                          'title': 'RIN Village',
                          'price': '\$350,000',
                          'location': 'Khan Toul Kork, Phnom Penh',
                          'bedrooms': 4,
                          'bathrooms': 3,
                          'area': '250 sqm',
                          'description':
                              'A cozy village property perfect for families.',
                          'specifications': [
                            '4 bedrooms with built-in wardrobes',
                            '2-car garage and private driveway',
                            'Open-plan kitchen and dining area',
                            'Close to schools and shopping centers',
                          ],
                        },
                        {
                          'image': 'assets/image/Image3.jpg',
                          'title': 'Sunset Villa',
                          'price': '\$1,200,000',
                          'location': 'Khan Daun Penh, Phnom Penh',
                          'bedrooms': 6,
                          'bathrooms': 5,
                          'area': '450 sqm',
                          'description':
                              'A stunning villa with breathtaking sunset views.',
                          'specifications': [
                            '6 bedrooms with panoramic views',
                            'Infinity pool overlooking the city',
                            'Home theater and entertainment room',
                            'Private gym and sauna',
                          ],
                        },
                        {
                          'image': 'assets/image/Image4.jpg',
                          'title': 'Modern Studio',
                          'price': '\$200,000',
                          'location': 'Khan Chamkar Mon, Phnom Penh',
                          'bedrooms': 1,
                          'bathrooms': 1,
                          'area': '60 sqm',
                          'description':
                              'A compact and modern studio for urban living.',
                          'specifications': [
                            '1 bedroom with built-in storage',
                            'Fully equipped kitchenette',
                            'Balcony with city views',
                            'Walking distance to public transport',
                          ],
                        },
                        {
                          'image': 'assets/image/Image5.jpg',
                          'title': 'Luxury Condo',
                          'price': '\$500,000',
                          'location': 'Khan Toul Kork, Phnom Penh',
                          'bedrooms': 3,
                          'bathrooms': 2,
                          'area': '200 sqm',
                          'description': 'A modern condo with luxury finishes.',
                          'specifications': [
                            '3 bedrooms with built-in wardrobes',
                            'Spacious living room with city views',
                            'Modern kitchen with high-end appliances',
                            'Private parking space',
                          ],
                        },
                        {
                          'image': 'assets/image/Image6.jpg',
                          'title': 'Elegant Villa',
                          'price': '\$1,500,000',
                          'location': 'Khan Chamkar Mon, Phnom Penh',
                          'bedrooms': 7,
                          'bathrooms': 6,
                          'area': '600 sqm',
                          'description':
                              'An elegant villa with a private garden.',
                          'specifications': [
                            '7 bedrooms with en-suite bathrooms',
                            'Private swimming pool and garden',
                            'Large dining and living areas',
                            'Home theater and gym',
                          ],
                        },
                        {
                          'image': 'assets/image/Property1.jpg',
                          'title': 'Cozy Apartment',
                          'price': '\$300,000',
                          'location': 'Khan Daun Penh, Phnom Penh',
                          'bedrooms': 2,
                          'bathrooms': 2,
                          'area': '120 sqm',
                          'description':
                              'A cozy apartment in the heart of the city.',
                          'specifications': [
                            '2 bedrooms with built-in wardrobes',
                            'Fully equipped kitchen',
                            'Balcony with city views',
                            'Close to public transport',
                          ],
                        },
                        {
                          'image': 'assets/image/Image3.jpg',
                          'title': 'Spacious Townhouse',
                          'price': '\$800,000',
                          'location': 'Khan Toul Kork, Phnom Penh',
                          'bedrooms': 4,
                          'bathrooms': 3,
                          'area': '350 sqm',
                          'description':
                              'A spacious townhouse with modern amenities.',
                          'specifications': [
                            '4 bedrooms with en-suite bathrooms',
                            'Private garden and parking',
                            'Modern kitchen and dining area',
                            'Close to schools and shopping centers',
                          ],
                        },
                      ];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SeeAllScreen(properties: allProperties),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(color: Color(0xFF322D29)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 320, // Adjust height to fit CardProperty with padding
                child: Builder(
                  builder: (context) {
                    // Define property data
                    final properties = [
                      {
                        'image': 'assets/image/Image1.jpg',
                        'title': 'The Mekong Garden',
                        'price': '\$750,000',
                        'location': 'Khan Chamkar Mon, Phnom Penh',
                        'bedrooms': 5,
                        'bathrooms': 4,
                        'area': '320 sqm',
                        'description':
                            'A luxurious garden property with modern amenities.',
                        'specifications': [
                          '5 bedrooms with en-suite bathrooms',
                          'Large garden and swimming pool',
                          'Modern kitchen with high-end appliances',
                          'Spacious living and dining areas',
                        ],
                      },
                      {
                        'image': 'assets/image/Image2.jpg',
                        'title': 'RIN Village',
                        'price': '\$350,000',
                        'location': 'Khan Toul Kork, Phnom Penh',
                        'bedrooms': 4,
                        'bathrooms': 3,
                        'area': '250 sqm',
                        'description':
                            'A cozy village property perfect for families.',
                        'specifications': [
                          '4 bedrooms with built-in wardrobes',
                          '2-car garage and private driveway',
                          'Open-plan kitchen and dining area',
                          'Close to schools and shopping centers',
                        ],
                      },
                      {
                        'image': 'assets/image/Image3.jpg',
                        'title': 'Sunset Villa',
                        'price': '\$1,200,000',
                        'location': 'Khan Daun Penh, Phnom Penh',
                        'bedrooms': 6,
                        'bathrooms': 5,
                        'area': '450 sqm',
                        'description':
                            'A stunning villa with breathtaking sunset views.',
                        'specifications': [
                          '6 bedrooms with panoramic views',
                          'Infinity pool overlooking the city',
                          'Home theater and entertainment room',
                          'Private gym and sauna',
                        ],
                      },
                      {
                        'image': 'assets/image/Image4.jpg',
                        'title': 'Modern Studio',
                        'price': '\$200,000',
                        'location': 'Khan Chamkar Mon, Phnom Penh',
                        'bedrooms': 1,
                        'bathrooms': 1,
                        'area': '60 sqm',
                        'description':
                            'A compact and modern studio for urban living.',
                        'specifications': [
                          '1 bedroom with built-in storage',
                          'Fully equipped kitchenette',
                          'Balcony with city views',
                          'Walking distance to public transport',
                        ],
                      },
                    ];
                    if (properties.isEmpty) {
                      return Center(
                        child: Text(
                          'No properties available.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }
                    return ListView.builder(
                      scrollDirection:
                          Axis.horizontal, // Enable horizontal scrolling
                      itemCount: properties.length, // Number of properties
                      itemBuilder: (context, index) {
                        final property = properties[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0), // Add spacing between cards
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 500),
                            child: Container(
                              width: 250, // Set a fixed width for each card
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                    child: GestureDetector(
                                      onTap: () {
                                        try {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  PropertyDetailPage(
                                                mainImage: property['image']!
                                                    as String,
                                                roomImages: [
                                                  'assets/images/room1.jpg',
                                                  'assets/images/room2.jpg',
                                                  'assets/images/room3.jpg',
                                                  'assets/images/room4.jpg',
                                                ],
                                                title: property['title']!
                                                    as String,
                                                price: property['price']!
                                                    as String,
                                                location: property['location']!
                                                    as String,
                                                description:
                                                    property['description']!
                                                        as String,
                                                specifications:
                                                    property['specifications']!
                                                        as List<String>,
                                              ),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Failed to navigate: $e'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                      child: Image.asset(
                                        property['image']! as String,
                                        fit: BoxFit.cover,
                                        height: 150,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 150,
                                            width: double.infinity,
                                            color: Colors.grey[300],
                                            child: Icon(Icons.broken_image,
                                                color: Colors.grey, size: 50),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          property['title']! as String,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          property['location']! as String,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(Icons.bed,
                                                size: 16, color: Colors.grey),
                                            SizedBox(width: 4),
                                            Text('${property['bedrooms']}'),
                                            SizedBox(width: 16),
                                            Icon(Icons.bathtub,
                                                size: 16, color: Colors.grey),
                                            SizedBox(width: 4),
                                            Text('${property['bathrooms']}'),
                                            SizedBox(width: 16),
                                            Icon(Icons.square_foot,
                                                size: 16, color: Colors.grey),
                                            SizedBox(width: 4),
                                            Text(property['area']! as String),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          property['price']! as String,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              // Recently Viewed Section
              Text(
                'Recently Viewed Properties',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  CardProperty(
                    image:
                        'assets/image/Image2.jpg', // Ensure this file exists in the assets/image/ folder
                    title: 'RIN Village',
                    price: '\$350,000',
                    details: '4  |  5  |  184 sqm',
                    location: 'Khan Chamkar Mon, Phnom Penh',
                    bedrooms: 4,
                    bathrooms: 5,
                    area: '184 sqm',
                    availability: 'Available',
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

class CardProperty extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String details;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final String area;
  final String availability;

  const CardProperty({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.details,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.availability,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image,
                          color: Colors.grey, size: 50),
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'For Sale',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bed, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text('$bedrooms', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.bathtub, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text('$bathrooms',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.square_foot, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(area, style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.key, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          availability,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Define the SeeAllScreen class
class SeeAllScreen extends StatelessWidget {
  final List<Map<String, dynamic>> properties;

  const SeeAllScreen({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Properties'),
      ),
      body: ListView.builder(
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
          return ListTile(
            leading: Image.asset(property['image']! as String),
            title: Text(property['title']! as String),
            subtitle: Text('${property['price']} - ${property['location']}'),
          );
        },
      ),
    );
  }
}

// Define a reusable FilterChipWidgetF
class FilterChipWidgetF extends StatefulWidget {
  final String label;

  const FilterChipWidgetF({super.key, required this.label});

  @override
  _FilterChipWidgetFState createState() => _FilterChipWidgetFState();
}

class _FilterChipWidgetFState extends State<FilterChipWidgetF> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.label),
      selected: isSelected,
      selectedColor: Color(0xFF322D29),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
      onSelected: (bool selected) {
        setState(() {
          isSelected = selected;
        });
      },
    );
  }
}

class ResultsPage extends StatelessWidget {
  final Map<String, dynamic> filters;

  const ResultsPage({super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    // Example property data
    final properties = [
      {
        'image': 'assets/image/Image1.jpg',
        'title': 'The Mekong Garden',
        'price': '\$750,000',
        'location': 'Phnom Penh',
        'bedrooms': 5,
        'bathrooms': 4,
        'area': '320 sqm',
        'description': 'A luxurious garden property with modern amenities.',
        'specifications': [
          '5 bedrooms with en-suite bathrooms',
          'Large garden and swimming pool',
          'Modern kitchen with high-end appliances',
        ],
      },
      {
        'image': 'assets/image/Image2.jpg',
        'title': 'RIN Village',
        'price': '\$350,000',
        'location': 'Phnom Penh',
        'bedrooms': 4,
        'bathrooms': 3,
        'area': '250 sqm',
        'description': 'A cozy village property perfect for families.',
        'specifications': [
          '4 bedrooms with built-in wardrobes',
          '2-car garage and private driveway',
          'Open-plan kitchen and dining area',
        ],
      },
       {
        'image': 'assets/image/Image3.jpg',
        'title': 'Sunset Villa',
        'price': '\$1,200,000',
        'location': 'Phnom Penh',
        'bedrooms': 6,
        'bathrooms': 5,
        'area': '450 sqm',
        'description':
            'A stunning villa with breathtaking sunset views.',
        'specifications': [
          '6 bedrooms with panoramic views',
          'Infinity pool overlooking the city',
          'Home theater and entertainment room',
          'Private gym and sauna',
        ],
      },
      {
        'image': 'assets/image/Image4.jpg',
        'title': 'Modern Studio',
        'price': '\$200,000',
        'location': 'Siem Reap',
        'bedrooms': 1,
        'bathrooms': 1,
        'area': '60 sqm',
        'description':
            'A compact and modern studio for urban living.',
        'specifications': [
          '1 bedroom with built-in storage',
          'Fully equipped kitchenette',
          'Balcony with city views',
          'Walking distance to public transport',
        ],
      },
      {
        'image': 'assets/image/Image5.jpg',
        'title': 'Luxury Condo',
        'price': '\$500,000',
        'location': 'Phnom Penh',
        'bedrooms': 3,
        'bathrooms': 2,
        'area': '200 sqm',
        'description': 'A modern condo with luxury finishes.',
        'specifications': [
          '3 bedrooms with built-in wardrobes',
          'Spacious living room with city views',
          'Modern kitchen with high-end appliances',
          'Private parking space',
        ],
      },
      {
        'image': 'assets/image/Image6.jpg',
        'title': 'Elegant Villa',
        'price': '\$1,500,000',
        'location': 'Phnom Penh',
        'bedrooms': 7,
        'bathrooms': 6,
        'area': '600 sqm',
        'description':
            'An elegant villa with a private garden.',
        'specifications': [
          '7 bedrooms with en-suite bathrooms',
          'Private swimming pool and garden',
          'Large dining and living areas',
          'Home theater and gym',
        ],
      },
      {
        'image': 'assets/image/Property1.jpg',
        'title': 'Cozy Apartment',
        'price': '\$300,000',
        'location': 'Phnom Penh',
        'bedrooms': 2,
        'bathrooms': 2,
        'area': '120 sqm',
        'description':
            'A cozy apartment in the heart of the city.',
        'specifications': [
          '2 bedrooms with built-in wardrobes',
          'Fully equipped kitchen',
          'Balcony with city views',
          'Close to public transport',
        ],
      },
      {
        'image': 'assets/image/Image3.jpg',
        'title': 'Spacious Townhouse',
        'price': '\$800,000',
        'location': 'Phnom Penh',
        'bedrooms': 4,
        'bathrooms': 3,
        'area': '350 sqm',
        'description':
            'A spacious townhouse with modern amenities.',
        'specifications': [
          '4 bedrooms with en-suite bathrooms',
          'Private garden and parking',
          'Modern kitchen and dining area',
          'Close to schools and shopping centers',
        ],
      },
    ];

    // Filter logic
    final filteredProperties = properties.where((property) {
      int matchCount = 0;

      // Check each condition and increment matchCount if it passes
      if (filters['selectedLocation'] != null &&
          filters['selectedLocation'] == property['location']) {
        print('Property: ${property['title']}, Match Count: $matchCount');
        matchCount++;
        print('Property: ${property['location']}, Match Count: $matchCount');
      }
      // Check budget range (combined condition for budgetMin and budgetMax)
      if (filters['budgetMin'] != null &&
          filters['budgetMax'] != null &&
          int.tryParse(filters['budgetMin'] as String) != null &&
          int.tryParse(filters['budgetMax'] as String) != null) {
        final propertyPrice = int.tryParse(
          (property['price'] as String).replaceAll(RegExp(r'[^0-9]'), ''),
        );
        final minBudget = int.parse(filters['budgetMin'] as String);
        final maxBudget = int.parse(filters['budgetMax'] as String);

        if (propertyPrice != null && propertyPrice >= minBudget && propertyPrice <= maxBudget) {
          print('Property: ${property['price']}, Match Count: $matchCount');
          matchCount++;
        }
      }
      if (filters['bedrooms'] != null &&
          int.tryParse(filters['bedrooms'] as String) != null &&
          int.parse(filters['bedrooms'] as String) <= (property['bedrooms'] as int)) {
        matchCount++;
        print('Property: ${property['bedrooms']}, Match Count: $matchCount');
      }

      // Include the property if at least 3 conditions are met
      return matchCount >= 3;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered Results'),
      ),
      body: filteredProperties.isEmpty
          ? const Center(
              child: Text('No properties match your filters.'),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of cards per row
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75, // Adjust the aspect ratio for card size
              ),
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                final property = filteredProperties[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyDetailPage(
                          mainImage: property['image'] as String,
                          roomImages: [
                            'assets/image/P_Room1.jpg',
                            'assets/image/P_Room2.jpg',
                            'assets/image/P_Room3.jpg',
                            'assets/image/P_Room4.jpg',
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
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                          child: Image.asset(
                            property['image'] as String,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 150,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.bed, size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text('${property['bedrooms']}'),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.bathtub, size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text('${property['bathrooms']}'),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                property['price'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
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
