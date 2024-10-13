import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:library_web/widgets/add_book.dart';
import 'package:library_web/widgets/view_books.dart';

class Books extends StatefulWidget {
  final GlobalKey<BooksState>? key;

  const Books({this.key}) : super(key: key);

  @override
  State<Books> createState() => BooksState();
}

class BooksState extends State<Books> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool addBook = false;

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    // Add your search logic here, such as querying a database or API.
    print("Searching for: $_searchQuery");
  }

  void closeForm(){
    setState(() {
      addBook = false;
    });
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
              addBook ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Set the background color of the button
                  foregroundColor: Colors.white, // Set the text (foreground) color
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), // Optional: Adjust padding
                ),
                onPressed: (){
                  closeForm();
                },
                child: const Text(
                  'Close Form',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ) :
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Set the background color of the button
                  foregroundColor: Colors.white, // Set the text (foreground) color
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), // Optional: Adjust padding
                ),
                onPressed: (){
                  setState(() {
                    addBook = true;
                  });
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
          ),
          addBook ? Expanded(child: AddBook()) : ViewBooks()
        ],
      ),
    );
  }
}
