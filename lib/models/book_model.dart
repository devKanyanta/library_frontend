import 'package:library_web/models/publisher_model.dart';

import 'author_model.dart';

class Book {
  final String title;
  final String isbn;
  final Publisher publisher;
  final int publicationYear;
  final String genreId;
  final int copiesAvailable;
  final String shelfLocation;
  final List<Author> authors;

  Book({
    required this.title,
    required this.isbn,
    required this.publisher,
    required this.publicationYear,
    required this.genreId,
    required this.copiesAvailable,
    required this.shelfLocation,
    required this.authors,
  });

  // Factory method to create an instance from JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      isbn: json['isbn'],
      publisher: Publisher.fromJson(json['publisher']),
      publicationYear: json['publication_year'],
      genreId: json['genre_id'],
      copiesAvailable: json['copies_available'],
      shelfLocation: json['shelf_location'],
      authors: List<Author>.from(json['authors'].map((author) => Author.fromJson(author))),
    );
  }

  // Convert Book instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isbn': isbn,
      'publisher': publisher.toJson(),
      'publication_year': publicationYear,
      'genre_id': genreId,
      'copies_available': copiesAvailable,
      'shelf_location': shelfLocation,
      'authors': authors.map((author) => author.toJson()).toList(),
    };
  }
}
