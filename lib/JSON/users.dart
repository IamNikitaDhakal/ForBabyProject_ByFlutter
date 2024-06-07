import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final int? userId;
  final String? fullName;
  final String? email;
  final String? password;

  Users({
    this.userId,
    this.fullName,
    required this.email,
    required this.password,
  });
// these json value must be same as that we defined in database.
  factory Users.fromMap(Map<String, dynamic> json) => Users(
        userId: json["userId"],
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "fullName": fullName,
        "email": email,
        "password": password,
      };
}
