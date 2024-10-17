import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/fine_model.dart';

class FineServices{
  final String baseUrl = 'http://localhost:3000'; // Replace with your API base URL

  Future<List<Fine>> fetchFines() async {
    final response = await http.get(Uri.parse('$baseUrl/fines'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['fines'];
      return data.map((fine) => Fine.fromJson(fine)).toList();
    } else {
      throw Exception('Failed to load fines: ${response.body}');
    }
  }

  Future<List<Fine>> fetchFinesByStudentId(String studentId) async {
    final response = await http.get(Uri.parse('$baseUrl/fines/student/$studentId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['fines'];
      return data.map((fine) => Fine.fromJson(fine)).toList();
    } else {
      throw Exception('Failed to load fines: ${response.body}');
    }
  }

  Future<void> checkDueLoansAndAddFine(String userId) async {
    final url = Uri.parse('http://localhost:3000/fines/check/$userId'); // Adjust the URL if needed

    try {
      final response = await http.get(url); // Use GET for fetching due loans

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Handle successful response
        print('Fines added successfully: ${responseData['fineIds']}');
      } else {
        // Handle error response
        final errorData = json.decode(response.body);
        print('Error: ${errorData['message']}');
      }
    } catch (error) {
      print('Failed to send request: $error');
    }
  }
}