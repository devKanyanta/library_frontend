import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Reservations extends StatefulWidget {
  const Reservations({super.key, this.userId});
  final userId;

  @override
  State<Reservations> createState() => _ReservationsState();
}

class Book {
  final int id;
  final String title;
  final int copiesAvailable;

  Book({required this.id, required this.title, required this.copiesAvailable});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      copiesAvailable: json['copies_available'],
    );
  }
}


class _ReservationsState extends State<Reservations> {

  Future<void> _reserveBook(int bookId) async {

    final url = Uri.parse('http://localhost:3000/reservations/add');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'book_id': bookId,
        'user_id': widget.userId, // Replace with actual user_id
        'librarian_id': 2022063457, // Replace with actual librarian_id
        'status': 'Reserved', // Adjust based on your use case
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book reserved successfully')),
      );
    } else {
      print(response.body);
      var jsonObject = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonObject['error'])),
      );
    }
  }

  Future<void> makeReservation(int bookId, int userId, int librarianId, String status) async {
    final response = await http.post(
      Uri.parse('http:/localhost:3000/reservations/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'book_id': bookId,
        'user_id': userId,
        'librarian_id': librarianId,
        'status': status,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully reserved
      print('Reservation successful');
    } else {
      throw Exception('Failed to reserve book');
    }
  }

  Future<List<Book>> fetchAvailableBooks() async {
    final response = await http.get(Uri.parse('http://localhost:3000/reservations/new'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List books = json.decode(response.body);
      return books.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load available books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: fetchAvailableBooks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  'Get Reservations for books not available'
              ),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final book = snapshot.data![index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text('No copies available'),
                  onTap: () {
                    _showReserveDialog(context, book);
                  },
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
  }

  // 3. Show confirmation dialog when user taps "Reserve"
  void _showReserveDialog(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reserve Book'),
          content: Text('Do you want to reserve "${book.title}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _reserveBook(book.id); // Call the reserve function
              },
              child: Text('Reserve'),
            ),
          ],
        );
      },
    );
  }
}
