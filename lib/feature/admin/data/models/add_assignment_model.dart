class AddAssignment {
  final int? sessionId;
  final String title;
  final DateTime deadline;
  final String assignmentUrl;

  AddAssignment({
    required this.sessionId,
    required this.title,
    required this.deadline,
    required this.assignmentUrl,
  });

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'title': title,
    'deadline': deadline.toUtc().toIso8601String(),
    'assignmentUrl': assignmentUrl,
  };
}
