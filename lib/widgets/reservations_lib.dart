import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/reservations_model.dart';
import 'package:http/http.dart' as http;

class ReservationListScreen extends StatefulWidget {
  @override
  _ReservationListScreenState createState() => _ReservationListScreenState();
}

class _ReservationListScreenState extends State<ReservationListScreen> {
  late Future<List<Reservation>> futureReservations;

  Future<List<Reservation>> fetchReservations() async {
    final response = await http.get(Uri.parse('http://localhost:3000/reservations/'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => Reservation.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load reservations');
    }
  }

  @override
  void initState() {
    super.initState();
    futureReservations = fetchReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservations'),
      ),
      body: FutureBuilder<List<Reservation>>(
        future: futureReservations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No reservations found.'));
          } else {
            final reservations = snapshot.data!;
            return ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                final reservation = reservations[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(reservation.bookTitle),
                    subtitle: Text('Reserved by: ${reservation.userFirstName} ${reservation.userLastName}'),
                    trailing: Text('Status: ${reservation.status}'),
                    onTap: () {
                      // Optionally, you can add functionality to tap the reservation for more details
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
