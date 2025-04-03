import 'package:flutter/material.dart';

class PropertyDetailPage extends StatefulWidget {
  final String mainImage;
  final List<String> roomImages;
  final String title;
  final String price;
  final String location;
  final String description;
  final List<String> specifications;

  const PropertyDetailPage({
    super.key,
    required this.mainImage,
    required this.roomImages,
    required this.title,
    required this.price,
    required this.location,
    required this.description,
    required this.specifications,
  });

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final PageController _roomImagesController = PageController();

  int _currentRoomImageIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    _roomImagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back,
                color: Color(0xFF2D3142), size: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.favorite_border,
                  color: Color(0xFF2D3142), size: 20),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to favorites'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  const Icon(Icons.share, color: Color(0xFF2D3142), size: 20),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Share options opened'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
        title: const Text(
          'Property Details',
          style: TextStyle(
            color: Color(0xFF2D3142),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main property image
                Container(
                  height: 280,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Display the main property image with shimmer effect and zoom-in animation
                        AnimatedScale(
                          scale: 1.0,
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset(
                            widget.mainImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image,
                                    color: Colors.grey, size: 50),
                              );
                            },
                          ),
                        ),

                        // Overlay gradient
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                              stops: const [0.7, 1.0],
                            ),
                          ),
                        ),

                        // Featured label
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2D3142),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  'FEATURED',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Property title, price, and location
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 18, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            widget.location,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.description,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),

                // Specifications
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Specifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...widget.specifications.map((spec) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.check,
                                    size: 16, color: Colors.green),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    spec,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),

                // Room images carousel - centered in the screen
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Room Images',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          Text(
                            '${_currentRoomImageIndex + 1}/${widget.roomImages.length}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            // PageView for swiping images
                            PageView.builder(
                              controller: _roomImagesController,
                              itemCount: widget.roomImages.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentRoomImageIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      widget.roomImages[index],
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.broken_image,
                                              color: Colors.grey, size: 50),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),

                            // Navigation arrows
                            Positioned.fill(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left arrow
                                  GestureDetector(
                                    onTap: () {
                                      if (_currentRoomImageIndex > 0) {
                                        _roomImagesController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 5,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Color(0xFF2D3142),
                                        size: 16,
                                      ),
                                    ),
                                  ),

                                  // Right arrow
                                  GestureDetector(
                                    onTap: () {
                                      if (_currentRoomImageIndex <
                                          widget.roomImages.length - 1) {
                                        _roomImagesController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 5,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xFF2D3142),
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Page indicator
                            Positioned(
                              bottom: 12,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  widget.roomImages.length,
                                  (index) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: _currentRoomImageIndex == index
                                        ? 20
                                        : 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: _currentRoomImageIndex == index
                                          ? const Color(0xFF2D3142)
                                          : Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),

          // Sticky button at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.message_outlined,
                        color: Color(0xFF2D3142),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Chat with agent'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tour request submitted'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D3142),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Request a Tour',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
