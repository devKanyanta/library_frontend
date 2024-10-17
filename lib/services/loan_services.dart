import 'dart:convert';

import '../models/loan_model.dart';
import 'package:http/http.dart' as http;

class LoanServices{

  // Fetch the loans from the API
  Future<List<Loan>> fetchLoans() async {
    final url = Uri.parse('http://localhost:3000/loans');  // Replace with your actual API URL
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> loanList = responseData['loans'];

      // Convert each JSON item into a Loan instance
      return loanList.map((loanJson) => Loan.fromJson(loanJson)).toList();
    } else {
      throw Exception('Failed to load loans');
    }
  }

  Future<List<Loan>> fetchLoansByStudent(String studentId) async {
    try {
      final url = Uri.parse('http://localhost:3000/loans/student/$studentId}');  // Update with your actual API
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> loanList = responseData['loans'];

        // Return empty list if no loans are found for the student
        if (loanList.isEmpty) {
          return [];
        }

        // Convert each JSON item into a Loan instance
        return loanList.map((loanJson) => Loan.fromJson(loanJson)).toList();
      } else {
        throw Exception('Failed to load loans. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching loans: $e');
    }
  }
}