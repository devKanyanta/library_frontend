import 'package:flutter/material.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    // Add your search logic here, such as querying a database or API.
    print("Searching for: $_searchQuery");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'View, Add or Edit Books',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                  color: Colors.grey[200],
                    borderRadius:
                    BorderRadius.circular(30.0), // Rounded corners
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search), // Search icon
                      hintText: "Search...",
                      border: InputBorder.none, // Remove default border
                    ),
                    onSubmitted:
                    _performSearch, // Perform search on submission
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Set the background color of the button
                  foregroundColor: Colors.white, // Set the text (foreground) color
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), // Optional: Adjust padding
                ),
                onPressed: (){

                },
                child: const Text(
                  'Add Book',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
