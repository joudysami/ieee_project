import 'dart:convert';

class UserModel {
  final String uId;
  final String name;
  final String email;
  final String role;
  final String? phone;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
     role: map['role'] ?? map['enrollment'] ?? 'Student',
      phone: map['phone'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source));
}