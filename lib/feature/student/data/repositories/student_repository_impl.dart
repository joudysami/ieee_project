import 'dart:developer';
import 'package:ieee/core/models/assignment_model.dart';
import 'package:ieee/core/models/session_model.dart';
import 'package:ieee/core/models/track_model.dart';
import '../../domain/repositories/student_repository.dart';
import '../datasources/student_remote_data_source.dart';
import '../models/student_home_data.dart';
import '../models/student_submission_model.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;

  StudentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> getDashboard(String studentId) async {
    try {
      return await remoteDataSource.getDashboard(studentId);
    } catch (e) {
      log('=== STUDENT REPO DASHBOARD ERROR ===');
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<SessionModel>> getSessionsByTrackId(int trackId) async {
    try {
      final raw = await remoteDataSource.getSessionsByTrackId(trackId);
      return raw
          .map((e) => SessionModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('=== STUDENT REPO SESSIONS ERROR ===');
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<AssignmentModel>> getAssignmentsByTrackId(int trackId) async {
    try {
      final raw = await remoteDataSource.getAssignmentsByTrackId(trackId);
      return raw
          .map((e) => AssignmentModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('=== STUDENT REPO ASSIGNMENTS ERROR ===');
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<StudentSubmissionModel>> getSubmissionsByUserId(
    String userId,
  ) async {
    try {
      final raw = await remoteDataSource.getSubmissionsByUserId(userId);
      return raw
          .map((e) => StudentSubmissionModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('=== STUDENT REPO SUBMISSIONS ERROR ===');
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<TrackModel> getTrackById(int trackId) async {
    try {
      final raw = await remoteDataSource.getTrackById(trackId);
      return TrackModel.fromMap(raw);
    } catch (e) {
      log('=== STUDENT REPO TRACK ERROR ===');
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<dynamic> getAttendanceByStudentId(String studentId) async {
    try {
      return await remoteDataSource.getAttendanceByStudentId(studentId);
    } catch (e) {
      log('=== STUDENT REPO ATTENDANCE ERROR ===');
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<StudentHomeData> loadHomeData({
    required String studentId,
    required String studentName,
    required int trackId,
  }) async {
    Map<String, dynamic>? rawDashboard;
    try {
      rawDashboard = await getDashboard(studentId);
      log('=== studentdashboard keys ===');
      log(rawDashboard.keys.toString());
    } catch (e) {
      // Dashboard schema unknown; Home can still render from other endpoints.
      log('Dashboard fetch failed (continuing): $e');
    }

    final sessions = await getSessionsByTrackId(trackId);
    final assignments = await getAssignmentsByTrackId(trackId);
    final submissions = await getSubmissionsByUserId(studentId);

    TrackModel? track;
    try {
      track = await getTrackById(trackId);
    } catch (e) {
      log('Track fetch failed (continuing): $e');
    }

    return StudentHomeData(
      studentName: studentName,
      upcomingSession: _pickUpcomingSession(sessions),
      track: track,
      submissions: submissions,
      totalAssignments: assignments.length,
      rawDashboard: rawDashboard,
    );
  }

  SessionModel? _pickUpcomingSession(List<SessionModel> sessions) {
    if (sessions.isEmpty) return null;

    final now = DateTime.now();
    SessionModel? best;
    DateTime? bestDate;

    for (final s in sessions) {
      final parsed = DateTime.tryParse(s.date ?? '');
      if (parsed == null) continue;
      if (parsed.isBefore(now.subtract(const Duration(hours: 3)))) continue;
      if (bestDate == null || parsed.isBefore(bestDate)) {
        best = s;
        bestDate = parsed;
      }
    }

    return best ?? sessions.first;
  }
}
