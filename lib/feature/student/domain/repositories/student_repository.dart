import 'package:ieee/core/models/assignment_model.dart';
import 'package:ieee/core/models/session_model.dart';
import 'package:ieee/core/models/track_model.dart';
import '../../data/models/student_home_data.dart';
import '../../data/models/student_submission_model.dart';

abstract class StudentRepository {
  Future<Map<String, dynamic>> getDashboard(String studentId);

  Future<List<SessionModel>> getSessionsByTrackId(int trackId);

  Future<List<AssignmentModel>> getAssignmentsByTrackId(int trackId);

  Future<List<StudentSubmissionModel>> getSubmissionsByUserId(String userId);

  Future<TrackModel> getTrackById(int trackId);

  /// Response schema not in Swagger — returned as dynamic for later mapping.
  Future<dynamic> getAttendanceByStudentId(String studentId);

  Future<StudentHomeData> loadHomeData({
    required String studentId,
    required String studentName,
    required int trackId,
  });
}
