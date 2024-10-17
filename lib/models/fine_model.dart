class Fine {
  final int id;
  final int loanId;
  final int studentId;
  final int amount;
  final String paymentStatus;
  final DateTime? paymentDate;
  final String firstName; // New field
  final String lastName;  // New field

  Fine({
    required this.id,
    required this.loanId,
    required this.studentId,
    required this.amount,
    required this.paymentStatus,
    this.paymentDate,
    required this.firstName, // New field
    required this.lastName,  // New field
  });

  factory Fine.fromJson(Map<String, dynamic> json) {
    return Fine(
      id: json['fine_id'],
      loanId: json['loan_id'],
      studentId: json['student_id'],
      amount: json['amount'],
      paymentStatus: json['payment_status'],
      paymentDate: json['payment_date'] != null ? DateTime.parse(json['payment_date']) : null,
      firstName: json['first_name'], // New field
      lastName: json['last_name'],   // New field
    );
  }
}
