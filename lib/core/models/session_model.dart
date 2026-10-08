import 'dart:convert';

class SessionModel {
  final int sessionId;
  final String? title;
  final String? date;
  final int duration;
  final String? meetingLink; // NEW
  final String? nextSessionTitle;
  final int trackId;

  SessionModel({
    required this.sessionId,
    this.title,
    this.date,
    required this.duration,
    this.meetingLink,
    this.nextSessionTitle,
    required this.trackId,
  });

  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'title': title,
      'date': date,
      'duration': duration,
      'meetingLink': meetingLink,
      'nextSessionTitle': nextSessionTitle,
      'trackId': trackId,
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      sessionId: map['sessionId']?.toInt() ?? 0,
      title: map['title'],
      date: map['date'],
      duration: map['duration']?.toInt() ?? 0,
      meetingLink: map['meetingLink'],
      nextSessionTitle: map['nextSessionTitle'],
      trackId: map['trackId']?.toInt() ?? 0,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory SessionModel.fromJson(String source) =>
      SessionModel.fromMap(jsonDecode(source));
}