class AdminDashboard {
  final int totalStudents;
  final int nofSessions;
  final List<dynamic> pendingAssignments;
  final int nofPendingAssignments;

  AdminDashboard({
    required this.totalStudents,
    required this.nofSessions,
    required this.pendingAssignments,
    required this.nofPendingAssignments,
  });

  factory AdminDashboard.fromMap(Map<String, dynamic> json) =>
      AdminDashboard(
        totalStudents: json['totalStudents'] ?? 0,
        nofSessions: json['nofSessions'] ?? 0,
        pendingAssignments: json['pendingAssignments'] ?? [],
        nofPendingAssignments: json['nofPendingAssignments'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    'totalStudents': totalStudents,
    'nofSessions': nofSessions,
    'pendingAssignments': pendingAssignments,
    'nofPendingAssignments': nofPendingAssignments,
  };
}