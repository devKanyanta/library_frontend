import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:library_web/models/book_model.dart';

class BookServices{
  static const String baseUrl = 'http://localhost:3000'; // Replace with your actual backend URL

  Future<String> addBook(Book book) async {
    final url = Uri.parse('$baseUrl/book/new');

    try {
      // Convert the Book object to JSON string using jsonEncode
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(book.toJson()), // Convert the book to a JSON string
      );

      // Check for a 201 Created status code
      if (response.statusCode == 201) {
        // Decode the response body
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['message'] ?? 'Book added successfully';
      } else {
        // Handle specific error codes or return a generic error message
        switch (response.statusCode) {
          case 401:
            throw 'Unauthorized: Invalid credentials';
          case 404:
            throw 'Not found: Endpoint does not exist';
          case 409:
            throw 'Conflict: Book already exists';
          case 400:
            throw 'Bad Request: Invalid data';
          default:
            throw 'Failed with status code: ${response.statusCode}';
        }
      }
    } catch (error) {
      return Future.error('Error: failed to upload the book. $error');
    }
  }


}