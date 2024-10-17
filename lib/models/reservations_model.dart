class Reservation {
  final int reservationId;
  final int bookId;
  final int userId;
  final int librarianId;
  final DateTime date;
  final String status;
  final String bookTitle;
  final String bookIsbn;
  final int copiesAvailable;
  final int publisherId;
  final int publicationYear;
  final String shelfLocation;
  final String userFirstName;
  final String userLastName;
  final String userEmail;
  final int? librarianUserId;

  Reservation({
    required this.reservationId,
    required this.bookId,
    required this.userId,
    required this.librarianId,
    required this.date,
    required this.status,
    required this.bookTitle,
    required this.bookIsbn,
    required this.copiesAvailable,
    required this.publisherId,
    required this.publicationYear,
    required this.shelfLocation,
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    this.librarianUserId,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationId: json['reservation_id'],
      bookId: json['book_id'],
      userId: json['user_id'],
      librarianId: json['librarian_id'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      bookTitle: json['book_title'],
      bookIsbn: json['book_isbn'],
      copiesAvailable: json['copies_available'],
      publisherId: json['publisher_id'],
      publicationYear: json['publication_year'],
      shelfLocation: json['shelf_location'],
      userFirstName: json['user_first_name'],
      userLastName: json['user_last_name'],
      userEmail: json['user_email'],
      librarianUserId: json['librarian_user_id'],
    );
  }
}
