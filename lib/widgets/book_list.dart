import 'dart:convert';
import 'dart:js_interop';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_web/main.dart';
import 'package:library_web/pages/home.dart';
import 'package:library_web/services/book_services.dart';

class BookList extends StatefulWidget {
  const BookList({super.key, required this.title, required this.isbn, required this.location, required this.copiesAvail, required this.id, required this.isStudent, required this.userId});

  final String title,isbn,location, userId;
  final int id, copiesAvail;
  final bool isStudent;

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {

  Future<void> addLoan({
    required int bookId,
    required String userId,
    required int librarianId,
    required String loanDate,
    required String dueDate,
    String? returnDate, // Optional, can be null
  }) async {
    final url = Uri.parse('http://localhost:3000/loans/new'); // Replace with your actual endpoint

    final Map<String, dynamic> loanData = {
      'book_id': bookId,
      'user_id': userId,
      'librarian_id': librarianId,
      'loan_date': loanDate,
      'due_date': dueDate,
      'return_date': returnDate // Can be null
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(loanData),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Loan added successfully")),
        );
        print('Loan added successfully. Loan ID: ${responseData['loanId']}');
      } else {
        print('Failed to add loan. Status Code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add loan: ${response.body}")),
        );
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              Text(
                'ISBN: ${widget.isbn}',
                style: const TextStyle(
                  fontSize: 16
                ),
              ),
              Text(
                'Copies Available: ${widget.copiesAvail}',
                style: const TextStyle(
                  fontSize: 16
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'Shelf: ${widget.location}',
            style: const TextStyle(
              fontSize: 16
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          widget.isStudent ? ElevatedButton(
            onPressed: (){
              addLoan(
                  bookId: widget.id,
                  userId: widget.userId,
                  librarianId: 2022063457,
                  loanDate: DateTime.timestamp().toString(),
                  dueDate: DateTime.timestamp().add(Duration(days: 7)).toIso8601String(),
              );
            },
            child: Text(
                'Get Loan'
            ),
          ) : IconButton(
            onPressed: () async {
              String responseText = '';

              try{
                String response = await BookServices().deleteBook(widget.id.toString());
                responseText = response;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(response))
                );

                context.go('/');

              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("An error occurred: $e"))
                );
              }
            },
            icon: const Icon(
                Icons.delete,
              color: Colors.redAccent,
            ),
          )
        ],
      ),
    );
  }
}
