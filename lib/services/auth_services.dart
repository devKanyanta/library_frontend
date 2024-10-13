import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  static const String baseUrl = 'http://localhost:3000'; // Replace with your actual backend URL

  // Register a new user
  Future<String> registerUser(String id, String firstName, String lastName, String email, String phoneNumber, String role, String password) async{
    final url = Uri.parse('$baseUrl/users/register');
    // Save email and user type to browser cache
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try{
      final response = await http.post(
        url,
        headers : {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'id': id,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phoneNumber,
          'role': role,
          'password': password
        })
      );

      if (response.statusCode == 201) {
        if (response.headers['content-type']?.contains('application/json') == true) {
          // Response is JSON, decode it
          final jsonResponse = jsonDecode(response.body);
          print("response is: ${response.body}");
          prefs.setString('email', email);
          prefs.setString('role', role);
          return jsonResponse['message'] ?? 'Account created successfully';
        } else {
          // Response is plain text, try to parse it manually (adjust parsing logic as needed)
          final plainTextResponse = response.body;
          print("response is: ${response.body}");
          prefs.setString('email', email);
          prefs.setString('role', role);
          return plainTextResponse;
        }
      } else {
        // Handle specific error codes or return a generic error message
        if (response.statusCode == 401) {
          return Future.error('Unauthorized: Invalid credentials');
        } else if (response.statusCode == 404) {
          return Future.error('Not found: Endpoint does not exist');
        } else if (response.statusCode == 409) {
          return Future.error('Conflict: The account already exists');
        } else if (response.statusCode == 400) {
          return Future.error('Bad Request: Invalid data');
        } else {
          return Future.error('Failed with status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('Error: $error');
      return Future.error('Failed to log in: $error');
    }
  }

  // Log in an existing user
  Future<String> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/users/login');
    // Save email and user type to browser cache
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      // Log the response status code and headers for debugging
      print('Response status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');

      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('application/json') == true) {
          // Response is JSON, decode it
          final jsonResponse = jsonDecode(response.body);
          print("response is: ${response.body}");
          prefs.setString('user_id', jsonResponse['user_id'].toString());
          prefs.setString('role', jsonResponse['role']);
          return jsonResponse['message'] ?? 'Login successful';
        } else {
          // Response is plain text, try to parse it manually (adjust parsing logic as needed)
          final plainTextResponse = response.body;
          // ... your parsing logic for plain text response
          print("response is: ${response.body}");
          prefs.setString('user_id', email);
          return plainTextResponse;
        }
      } else {
        // Handle specific error codes or return a generic error message
        if (response.statusCode == 401) {
          return Future.error('Unauthorized');
        } else if (response.statusCode == 404) {
          return Future.error('Not found');
        } else {
          return Future.error('Login failed with status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('Error: $error');
      return Future.error('Failed to log in: $error');
    }
  }
}
