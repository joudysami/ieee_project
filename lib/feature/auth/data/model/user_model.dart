import 'dart:convert';

class UserModel {
  final String uId;
  final String name;
  final String email;
  final String role;
  final String? phone;
  final String? institute;
  final String? idToken;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.institute,
    this.idToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uId,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'institute': institute,
      'idToken': idToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? map['enrollment'] ?? 'Student',
      phone: map['phone'],
      institute: map['institute'],
      idToken: map['idToken'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source));
}
