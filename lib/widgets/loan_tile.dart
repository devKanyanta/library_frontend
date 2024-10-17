import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoanTile extends StatelessWidget {
  final int loanId;
  final String bookTitle;
  final String borrowerName;
  final String dueDate;
  final String studentId;
  final bool returned;

  LoanTile({
    required this.loanId,
    required this.bookTitle,
    required this.borrowerName,
    required this.dueDate,
    required this.studentId,
    required this.returned,
  });

  // Function to update the return date
  Future<void> updateReturnDate(BuildContext context) async {
    final url = Uri.parse('http://localhost:3000/update/loans/$loanId');
    final body = json.encode({
      'return_date': DateTime.now().toIso8601String(),  // Set return date to current date
    });

    try {
      final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Return date updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update return date')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating return date')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(bookTitle),
      subtitle: Text('Borrowed by: $borrowerName\nDue: $dueDate\nReturned: ${returned}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Student ID: $studentId'),
          ElevatedButton(
            onPressed: () => updateReturnDate(context),  // Call the function to update return date
            child: Text('Mark as returned'),
          ),
        ],
      ),
    );
  }
}
