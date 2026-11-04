import 'package:ieee/core/models/session_model.dart';
import 'package:ieee/core/models/track_model.dart';
import 'student_submission_model.dart';

/// Composed Home payload from documented endpoints + cached user.
/// Raw `/studentdashboard` body is kept for inspection until Swagger
/// documents its response schema (currently 200 OK with no schema).
class StudentHomeData {
  final String studentName;
  final SessionModel? upcomingSession;
  final TrackModel? track;
  final List<StudentSubmissionModel> submissions;
  final int totalAssignments;
  final Map<String, dynamic>? rawDashboard;

  const StudentHomeData({
    required this.studentName,
    required this.submissions,
    required this.totalAssignments,
    this.upcomingSession,
    this.track,
    this.rawDashboard,
  });

  /// Share of assignments that have any submission record.
  double get assignmentsProgress {
    if (totalAssignments <= 0) return 0;
    final done = submissions.length.clamp(0, totalAssignments);
    return done / totalAssignments;
  }

  int get assignmentsPercent => (assignmentsProgress * 100).round();
}
