class User {
  final String id;
  final String username;
  final String password;
  final String firstName;
  final String lastName;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password, // Be cautious with handling passwords
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
