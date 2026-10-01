import 'dart:convert';

class AssignmentModel {
  final int assignmentId;
  final String? title;
  final String? deadline;
  final String? status;
  final int sessionId;
  final String assignmentUrl;

  AssignmentModel({
    required this.assignmentId,
    this.title,
    this.deadline,
    this.status,
    required this.sessionId,
    this.assignmentUrl = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'assignmentId': assignmentId,
      'title': title,
      'deadline': deadline,
      'status': status,
      'sessionId': sessionId,
      'assignmentUrl': assignmentUrl,
    };
  }

  factory AssignmentModel.fromMap(Map<String, dynamic> map) {
    return AssignmentModel(
      assignmentId: map['assignmentId']?.toInt() ?? 0,
      title: map['title'],
      deadline: map['deadline'],
      status: map['status'],
      sessionId: map['sessionId']?.toInt() ?? 0,
      assignmentUrl: map['assignmentUrl'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory AssignmentModel.fromJson(String source) =>
      AssignmentModel.fromMap(jsonDecode(source));
}