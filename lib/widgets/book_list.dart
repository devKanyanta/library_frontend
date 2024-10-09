import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_web/main.dart';
import 'package:library_web/pages/home.dart';
import 'package:library_web/services/book_services.dart';

class BookList extends StatefulWidget {
  const BookList({super.key, required this.title, required this.isbn, required this.location, required this.copiesAvail, required this.id});

  final String title,isbn,location;
  final int id, copiesAvail;

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {

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
          IconButton(
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
