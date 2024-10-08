class Publisher {
  final String name;
  final String address;
  final String phoneNumber;

  Publisher({
    required this.name,
    required this.address,
    required this.phoneNumber,
  });

  // Factory method to create an instance from JSON
  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      name: json['name'],
      address: json['address'],
      phoneNumber: json['phone_number'],
    );
  }

  // Convert Publisher instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
    };
  }
}
