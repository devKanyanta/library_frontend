import 'package:flutter/material.dart';
import 'package:library_web/services/fine_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/fine_model.dart';

class FineListScreen extends StatefulWidget {
  const FineListScreen({super.key, required this.role});
  final String role;
  @override
  _FineListScreenState createState() => _FineListScreenState();
}

class _FineListScreenState extends State<FineListScreen> {
  Future<List<Fine>>? futureFines;
  String user_id = '';

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.get('user_id').toString();
    if(widget.role == 'Librarian'){
      setState(() {
        print('lib');
        futureFines = FineServices().fetchFines();
      });
    }else if (widget.role == 'Student'){
      print('checking: $user_id');
      setState(() {
        futureFines = FineServices().fetchFinesByStudentId(user_id);
      });
    }
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
        title: Text('Fines'),
      ),
      body: FutureBuilder<List<Fine>>(
        future: futureFines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No fines found.'));
          }

          final fines = snapshot.data!;
          return ListView.builder(
            itemCount: fines.length,
            itemBuilder: (context, index) {
              final fine = fines[index];
              return Card(  // Adding a Card for better UI presentation
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Fine ID: ${fine.id}, Amount: \K${fine.amount}.00'),
                  subtitle: Text(
                    'Status: ${fine.paymentStatus}\n'
                        'User: ${fine.firstName} ${fine.lastName}',
                  ),
                  isThreeLine: true,  // Enables multiline for subtitle
                ),
              );
            },
          );
        },
      ),
    );
  }
}
