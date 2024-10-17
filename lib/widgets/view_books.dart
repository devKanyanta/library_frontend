import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:library_web/widgets/book_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewBooks extends StatefulWidget {
  const ViewBooks({super.key});

  @override
  State<ViewBooks> createState() => _ViewBooksState();
}

class Book {
  final int id;
  final String title;
  final String isbn;
  final int publisherId;
  final int publicationYear;
  final int genreId;
  final int copiesAvailable;
  final String shelfLocation;

  Book({
    required this.id,
    required this.title,
    required this.isbn,
    required this.publisherId,
    required this.publicationYear,
    required this.genreId,
    required this.copiesAvailable,
    required this.shelfLocation,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      isbn: json['isbn'],
      publisherId: json['publisher_id'],
      publicationYear: json['publication_year'],
      genreId: json['genre_id'],
      copiesAvailable: json['copies_available'],
      shelfLocation: json['shelf_location'],
    );
  }
}

class _ViewBooksState extends State<ViewBooks> {
  List<Book> books = [];
  bool isLoading = true;
  bool isStudent = true;
  String userId = '';

  @override
  void initState() {
    super.initState();
    fetchBooks();
    determineRole();
  }

  void determineRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.get('user_id').toString();
    if (prefs.get('role') == 'librarian') {
      setState(() {
        isStudent = false;
      });
    } else if (prefs.get('role') == "student") {
      setState(() {
        isStudent = true;
      });
    } else {
    }
  }

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse('http://localhost:3000/books'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        books = (data['books'] as List).map((book) => Book.fromJson(book)).toList();
        isLoading = false;
      });
    } else {
      // Handle errors
      setState(() {
        isLoading = false;
      });
      print('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return BookList(
              title: book.title,
              isbn: book.isbn,
              location: book.shelfLocation,
              copiesAvail: book.copiesAvailable,
              id: book.id,
            isStudent: isStudent,
            userId: userId,);
        },
      ),
    );
  }
}
