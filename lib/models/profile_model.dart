class Profile {
  final String firstName;
  final String lastName;
  final String email;
  final String? avatarURL;

  Profile(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.avatarURL});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        avatarURL: json['avatarURL']);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'avatarURL': avatarURL
    };
  }
}
