class CreateSession {
  final int trackId;
  final String title;
  final String description;
  final DateTime date;
  final int duration;
  final String resources;

  CreateSession({
    required this.trackId,
    required this.title,
    required this.description,
    required this.date,
    required this.duration,
    required this.resources,
  });

  Map<String, dynamic> toJson() => {
    'trackId': trackId,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'duration': duration,
    'resources': resources,
  };
}
