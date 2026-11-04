import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ieee/core/constant/api_endpoint.dart';
import 'package:ieee/core/network/api_client.dart';

abstract class StudentRemoteDataSource {
  /// Swagger: GET `/studentdashboard` query `studentId` — response schema not documented.
  Future<Map<String, dynamic>> getDashboard(String studentId);

  /// Swagger: GET `/SessionsByTrackID` query `TrackId`.
  Future<List<dynamic>> getSessionsByTrackId(int trackId);

  /// Swagger: GET `/GetAllAssignmentsByTrackId` query `trackId`.
  Future<List<dynamic>> getAssignmentsByTrackId(int trackId);

  /// Swagger: GET `/api/Submission/StudentAllSubmission` query `userId`
  /// → `StudentAllSubmissionView[]`.
  Future<List<dynamic>> getSubmissionsByUserId(String userId);

  /// Swagger: GET `/Gettrackbyid` query `trackId` → `TrackView`.
  Future<Map<String, dynamic>> getTrackById(int trackId);

  /// Swagger: GET `/GetAttendanceByStudentId` query `studentId` — no response schema.
  Future<dynamic> getAttendanceByStudentId(String studentId);
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  /// Correct Swagger path (existing [ApiEndpoint.trackById] does not match Swagger).
  static const String _trackByIdPath = '/Gettrackbyid';

  /// Correct Swagger path (existing path-template constant does not match Swagger).
  static const String _studentAllSubmissionPath =
      '/api/Submission/StudentAllSubmission';

  @override
  Future<Map<String, dynamic>> getDashboard(String studentId) async {
    try {
      final response = await ApiClient.get(
        path: ApiEndpoint.getStudentDashBoard,
        queryParameters: {'studentId': studentId},
      );
      final data = response.data;
      if (data is Map<String, dynamic>) return data;
      if (data is Map) return Map<String, dynamic>.from(data);
      log('studentdashboard unexpected type: ${data.runtimeType}');
      return <String, dynamic>{'raw': data};
    } on DioException catch (e) {
      log('=== STUDENT DASHBOARD ERROR ===');
      log(e.response?.data.toString() ?? e.message ?? 'Unknown');
      throw Exception('Failed to load student dashboard: ${e.message}');
    }
  }

  @override
  Future<List<dynamic>> getSessionsByTrackId(int trackId) async {
    try {
      final response = await ApiClient.get(
        path: ApiEndpoint.sessionsByTrackID,
        queryParameters: {'TrackId': trackId},
      );
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      log('=== STUDENT SESSIONS ERROR ===');
      log(e.response?.data.toString() ?? e.message ?? 'Unknown');
      throw Exception('Failed to load sessions: ${e.message}');
    }
  }

  @override
  Future<List<dynamic>> getAssignmentsByTrackId(int trackId) async {
    try {
      final response = await ApiClient.get(
        path: ApiEndpoint.getAllAssignmentsByTrackId,
        queryParameters: {'trackId': trackId},
      );
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      log('=== STUDENT ASSIGNMENTS ERROR ===');
      log(e.response?.data.toString() ?? e.message ?? 'Unknown');
      throw Exception('Failed to load assignments: ${e.message}');
    }
  }

  @override
  Future<List<dynamic>> getSubmissionsByUserId(String userId) async {
    try {
      final response = await ApiClient.get(
        path: _studentAllSubmissionPath,
        queryParameters: {'userId': userId},
      );
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      log('=== STUDENT SUBMISSIONS ERROR ===');
      log(e.response?.data.toString() ?? e.message ?? 'Unknown');
      throw Exception('Failed to load submissions: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> getTrackById(int trackId) async {
    try {
      final response = await ApiClient.get(
        path: _trackByIdPath,
        queryParameters: {'trackId': trackId},
      );
      final data = response.data;
      if (data is Map<String, dynamic>) return data;
      if (data is Map) return Map<String, dynamic>.from(data);
      throw Exception('Unexpected track response type: ${data.runtimeType}');
    } on DioException catch (e) {
      log('=== STUDENT TRACK ERROR ===');
      log(e.response?.data.toString() ?? e.message ?? 'Unknown');
      throw Exception('Failed to load track: ${e.message}');
    }
  }

  @override
  Future<dynamic> getAttendanceByStudentId(String studentId) async {
    try {
      final response = await ApiClient.get(
        path: ApiEndpoint.getAttendanceByStudentId,
        queryParameters: {'studentId': studentId},
      );
      return response.data;
    } on DioException catch (e) {
      log('=== STUDENT ATTENDANCE ERROR ===');
      log(e.response?.data.toString() ?? e.message ?? 'Unknown');
      throw Exception('Failed to load attendance: ${e.message}');
    }
  }
}
