import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String companyName;
  final String email;
  final String location;
  final String password;
  final String role;
  final String profile;
  final String token;
  User({
    required this.id,
    required this.companyName,
    required this.email,
    required this.location,
    required this.password,
    required this.role,
    required this.profile,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyName': companyName,
      'email': email,
      'location': location,
      'password': password,
      'role': role,
      'profile': profile,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? "",
      companyName: map['companyName'] ?? "",
      email: map['email'] ?? "",
      location: map['location'] ?? "",
      password: map['password'] ?? "",
      role: map['role'] ?? "",
      profile: map['profile'] ?? "",
      token: map['token'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
