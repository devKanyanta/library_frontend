import 'dart:convert';
import 'package:go_router/go_router.dart';

import 'books.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_web/services/book_services.dart';
import '../models/book_model.dart';
import '../models/genre_model.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBook createState() => _AddBook();
}

class _AddBook extends State<AddBook> {
  final GlobalKey<BooksState> _booksKey = GlobalKey<BooksState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _publisherNameController = TextEditingController();
  final TextEditingController _publisherAddressController = TextEditingController();
  final TextEditingController _publisherPhoneNumberController = TextEditingController();
  final TextEditingController _publicationYearController = TextEditingController();
  final TextEditingController _copiesAvailableController = TextEditingController();
  final TextEditingController _shelfLocationController = TextEditingController();
  final TextEditingController _authorFirstNameController = TextEditingController();
  final TextEditingController _authorLastNameController = TextEditingController();
  final TextEditingController _authorNationalityController = TextEditingController();
  final TextEditingController _authorDobController = TextEditingController();
  bool isLoading = false;
  String? _selectedGenre;
  List<Genre> _genres = []; // Example genres

  @override
  void initState() {
    super.initState();
    _fetchGenres(); // Fetch genres when the form is initialized
  }

  Future<void> _fetchGenres() async {
    final response = await http.get(Uri.parse('http://localhost:3000/genres'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      print(response.body);

      // Assuming genres are wrapped inside a 'genres' key
      final List<dynamic> genreList = jsonResponse['genres']; // Extract the list

      setState(() {
        _genres = genreList.map((json) => Genre.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load genres');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
      appBar: AppBar(
        title: const Text('Add New Book',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Field
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the book title';
                    }
                    return null;
                  },
                ),

                // ISBN Field
                TextFormField(
                  controller: _isbnController,
                  decoration: InputDecoration(labelText: 'ISBN'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the ISBN';
                    }
                    return null;
                  },
                ),

                // Publisher Name Field
                TextFormField(
                  controller: _publisherNameController,
                  decoration: InputDecoration(labelText: 'Publisher Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the publisher name';
                    }
                    return null;
                  },
                ),

                // Publisher Address Field
                TextFormField(
                  controller: _publisherAddressController,
                  decoration: InputDecoration(labelText: 'Publisher Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the publisher address';
                    }
                    return null;
                  },
                ),

                // Publisher Phone Number Field
                TextFormField(
                  controller: _publisherPhoneNumberController,
                  decoration: InputDecoration(labelText: 'Publisher Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the publisher phone number';
                    }
                    return null;
                  },
                ),

                // Publication Year Field
                TextFormField(
                  controller: _publicationYearController,
                  decoration: InputDecoration(labelText: 'Publication Year'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the publication year';
                    }
                    return null;
                  },
                ),

                // Genre Dropdown
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Genre'),
                  value: _selectedGenre == null ? null : int.tryParse(_selectedGenre!),
                  items: _genres.map((Genre genre) {
                    return DropdownMenuItem<int>(
                      value: genre.id,
                      child: Text(genre.name),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGenre = newValue.toString();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a genre';
                    }
                    return null;
                  },
                ),

                // Copies Available Field
                TextFormField(
                  controller: _copiesAvailableController,
                  decoration: InputDecoration(labelText: 'Copies Available'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of copies available';
                    }
                    return null;
                  },
                ),

                // Shelf Location Field
                TextFormField(
                  controller: _shelfLocationController,
                  decoration: InputDecoration(labelText: 'Shelf Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the shelf location';
                    }
                    return null;
                  },
                ),

                // Author First Name Field
                TextFormField(
                  controller: _authorFirstNameController,
                  decoration: InputDecoration(labelText: 'Author First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the author\'s first name';
                    }
                    return null;
                  },
                ),

                // Author Last Name Field
                TextFormField(
                  controller: _authorLastNameController,
                  decoration: InputDecoration(labelText: 'Author Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the author\'s last name';
                    }
                    return null;
                  },
                ),

                // Author Nationality Field
                TextFormField(
                  controller: _authorNationalityController,
                  decoration: InputDecoration(labelText: 'Author Nationality'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the author\'s nationality';
                    }
                    return null;
                  },
                ),

                // Author DOB Field
                TextFormField(
                  controller: _authorDobController,
                  decoration: InputDecoration(labelText: 'Author DOB (YYYY-MM-DD)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the author\'s date of birth';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16)
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed to submit data
                      _submitBook();
                    }
                  },
                  child: const Text(
                      'Add Book',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitBook() async{
    isLoading = true;
    // Create a JSON object from form data
    final bookJson = {
      "title": _titleController.text,
      "isbn": _isbnController.text,
      "publisher": {
        "name": _publisherNameController.text,
        "address": _publisherAddressController.text,
        "phone_number": _publisherPhoneNumberController.text,
      },
      "publication_year": int.parse(_publicationYearController.text),
      "genre_id": _selectedGenre, // Assuming genres are indexed from 1
      "copies_available": int.parse(_copiesAvailableController.text),
      "shelf_location": _shelfLocationController.text,
      "authors": [
        {
          "first_name": _authorFirstNameController.text,
          "last_name": _authorLastNameController.text,
          "nationality": _authorNationalityController.text,
          "dob": _authorDobController.text,
        }
      ]
    };
    Book book = Book.fromJson(bookJson);
    String response = '';

    try{
      String uploadBook = await BookServices().addBook(book);

      response = uploadBook;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
      isLoading = false;
      context.go('/');

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void dispose() {
    // Dispose controllers when the form is closed
    _titleController.dispose();
    _isbnController.dispose();
    _publisherNameController.dispose();
    _publisherAddressController.dispose();
    _publisherPhoneNumberController.dispose();
    _publicationYearController.dispose();
    _copiesAvailableController.dispose();
    _shelfLocationController.dispose();
    _authorFirstNameController.dispose();
    _authorLastNameController.dispose();
    _authorNationalityController.dispose();
    _authorDobController.dispose();
    super.dispose();
  }
}
