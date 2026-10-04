class TrackStudent {
  final String userName;
  final num userScore;
  final int attendHasDone;
  final int assignmentHaseDone;
  final int nofSessions;
  final int nofAssignments;

  TrackStudent({
    required this.userName,
    required this.userScore,
    required this.attendHasDone,
    required this.assignmentHaseDone,
    required this.nofSessions,
    required this.nofAssignments,
  });

  factory TrackStudent.fromJson(Map<String, dynamic> json) => TrackStudent(
    userName: json['userName'] ?? '',
    userScore: json['userScore'] ?? 0,
    attendHasDone: json['attendHasDone'] ?? 0,
    assignmentHaseDone: json['assignmentHaseDone'] ?? 0,
    nofSessions: json['nofSessions'] ?? 0,
    nofAssignments: json['nofAssignments'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'userScore': userScore,
    'attendHasDone': attendHasDone,
    'assignmentHaseDone': assignmentHaseDone,
    'nofSessions': nofSessions,
    'nofAssignments': nofAssignments,
  };
}