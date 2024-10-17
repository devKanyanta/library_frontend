import 'package:flutter/material.dart';
import 'package:library_web/services/loan_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/loan_model.dart';

class StudentLoans extends StatefulWidget {
  const StudentLoans({super.key});

  @override
  State<StudentLoans> createState() => _StudentLoansState();
}

class _StudentLoansState extends State<StudentLoans> {
  Future<List<Loan>>? futureLoans;
  String userId = '';

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.get('user_id').toString();
    print(userId);

    // Trigger rebuilding of the widget tree with the new loans
    setState(() {
      futureLoans = LoanServices().fetchLoansByStudent(userId);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loans List'),
      ),
      body: FutureBuilder<List<Loan>>(
        future: futureLoans,
        builder: (context, snapshot) {
          // Check the connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Circular loading indicator
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: const Text('No loans available'));
          } else {
            final loans = snapshot.data!;
            return ListView.builder(
              itemCount: loans.length,
              itemBuilder: (context, index) {
                final loan = loans[index];
                return ListTile(
                  title: Text(loan.bookTitle),
                  subtitle: Text('Borrowed by: ${loan.borrowerName}\nDue: ${loan.dueDate}'),
                  trailing: Text('Student ID: ${loan.studentId}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
