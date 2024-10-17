class Loan {
  final int loanId;
  final String bookTitle;
  final String bookIsbn;
  final String borrowerName;
  final String borrowerEmail;
  final String studentId;
  final String librarianName;
  final String loanDate;
  final String dueDate;
  final String? returnDate;

  Loan({
    required this.loanId,
    required this.bookTitle,
    required this.bookIsbn,
    required this.borrowerName,
    required this.borrowerEmail,
    required this.studentId,
    required this.librarianName,
    required this.loanDate,
    required this.dueDate,
    this.returnDate,
  });

  // Factory method to create a Loan instance from JSON
  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      loanId: json['loan_id'],
      bookTitle: json['book_title'],
      bookIsbn: json['book_isbn'],
      borrowerName: json['borrower_name'],
      borrowerEmail: json['borrower_email'],
      studentId: json['student_id'].toString(),
      librarianName: json['librarian_name'],
      loanDate: json['loan_date'],
      dueDate: json['due_date'],
      returnDate: json['return_date'],
    );
  }
}