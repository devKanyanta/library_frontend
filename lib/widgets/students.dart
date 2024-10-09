import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  TextEditingController _searchController = TextEditingController();
  List<User> users = [];
  bool isLoading = true;

  void _performSearch(String query){

  }

  Future<void> fetchStudents() async {
    setState(() {
      isLoading = true; // Start loading indicator
    });

    try {
      final response = await http.get(Uri.parse('http://localhost:3000/users'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Ensure data is a List and parse it into User objects
        setState(() {
          users = data.map((item) => User.fromJson(item as Map<String, dynamic>)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching users: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator()) : Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'View Students',
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
                    (_performSearch), // Perform search on submission
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${user.email}'),
                        Text('Phone: ${user.phoneNumber}'),
                        Text('Role: ${user.role}'),
                        Text('Created At: ${user.createdAt}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
