class CreateSession {
  final int trackId;
  final String sessionLeaderId;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final int duration;
  final String resources;

  CreateSession({
    required this.trackId,
    required this.sessionLeaderId,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.duration,
    required this.resources,
  });

  factory CreateSession.fromMap(Map<String, dynamic> map) {
    return CreateSession(
      trackId: map['trackId'] ?? 0,
      sessionLeaderId: map['sessionLeaderID'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: DateTime.parse(map['date']),
      time: map['time'] ?? '',
      duration: map['duration'] ?? 0,
      resources: map['resources'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'trackId': trackId,
    'sessionLeaderID': sessionLeaderId,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'time': time,
    'duration': duration,
    'resources': resources,
  };
}
