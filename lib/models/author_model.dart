class Author {
  final String firstName;
  final String lastName;
  final String nationality;
  final String dob;

  Author({
    required this.firstName,
    required this.lastName,
    required this.nationality,
    required this.dob,
  });

  // Factory method to create an instance from JSON
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      firstName: json['first_name'],
      lastName: json['last_name'],
      nationality: json['nationality'],
      dob: json['dob'],
    );
  }

  // Convert Author instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'nationality': nationality,
      'dob': dob,
    };
  }
}
