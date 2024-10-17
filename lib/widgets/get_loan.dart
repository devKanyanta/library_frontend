import 'package:flutter/material.dart';
import 'package:library_web/widgets/view_books.dart';

import 'add_book.dart';

class GetLoan extends StatefulWidget {
  const GetLoan({super.key});

  @override
  State<GetLoan> createState() => _GetLoanState();
}

class _GetLoanState extends State<GetLoan> {
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
              'View books and get loans',
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
            ],
          ),
          ViewBooks()
        ],
      ),
    );
  }
}
