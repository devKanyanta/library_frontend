import 'package:flutter/material.dart';
import 'package:library_web/services/loan_services.dart';
import 'package:library_web/widgets/loan_tile.dart';

import '../models/loan_model.dart';

class Loans extends StatefulWidget {
  const Loans({super.key});

  @override
  State<Loans> createState() => _LoansState();
}

class _LoansState extends State<Loans> {
  late Future<List<Loan>> futureLoans;

  @override
  void initState() {
    super.initState();
    futureLoans = LoanServices().fetchLoans();  // Fetch the loans when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Student's Loans"),
      ),
      body: FutureBuilder<List<Loan>>(
        future: futureLoans,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No loans available'));
          } else {
            final loans = snapshot.data!;
            return ListView.builder(
              itemCount: loans.length,
              itemBuilder: (context, index) {
                final loan = loans[index];
                bool returned = false;

                if(loan.returnDate!=null){
                  returned = true;
                }else{
                  returned = false;
                }
                return LoanTile(loanId:
                loan.loanId,
                    bookTitle: loan.bookTitle,
                    borrowerName: loan.borrowerName,
                    dueDate: loan.dueDate,
                    studentId: loan.studentId,
                  returned: returned,
                );
              },
            );
          }
        },
      ),
    );
  }
}
