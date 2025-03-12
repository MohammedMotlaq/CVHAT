class User {
  final String firstName;
  final String lastName;
  final String email;
  final String token;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      token: json['token'],
    );
  }
}
