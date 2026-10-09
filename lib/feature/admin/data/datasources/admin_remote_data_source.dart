import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../core/constant/api_endpoint.dart';
import '../../../../core/network/api_client.dart';

abstract class AdminRemoteDataSource {
  Future<Map<String, dynamic>> getDashboard(String trackId);
  Future<List<dynamic>> getSessionByTrackId(String trackId);
  Future<void> addAssignment(Map<String, dynamic> body);
  Future<List<dynamic>> getReviewsByTrackId(String trackId);
  Future<void> addSession(
    String trackId,
    String sessionLeaderId,
    String sessionName,
    String sessionDescription,
    String sessionDate,
    String sessionTime,
    String duration,
    String resourse,
  );
}
/*-------------------------------------------------------------------------------------------*/

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  @override
  Future<Map<String, dynamic>> getDashboard(String trackId) async {
    try {
      final response = await ApiClient.get(
        path: ApiEndpoint.getAdminDashBoard,
        queryParameters: {'trackId': trackId},
      );
      return response.data;
    } on DioException catch (e) {
      log('=== BACKEND ERROR MESSAGE ===');
      log(e.response?.data.toString() ?? 'Unknown error');
      log('=============================');
      throw Exception('Failed to load dashboard: ${e.message}');
    }
  }

  @override
  Future<List<dynamic>> getSessionByTrackId(String trackId) async {
    try {
      final response = await ApiClient.get(
        path: ApiEndpoint.sessionsByTrackID,
        queryParameters: {'trackId': trackId},
      );
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      log('=== BACKEND ERROR MESSAGE ===');
      log(e.response?.data.toString() ?? 'Unknown error');
      log('=============================');
      throw Exception('Failed to load dashboard: ${e.message}');
    }
  }

  @override
  Future<void> addAssignment(Map<String, dynamic> body) async {
    try {
      await ApiClient.post(
        path: ApiEndpoint.addAssignment,
        data: body,
      );
    } on DioException catch (e) {
      log('=== BACKEND ERROR MESSAGE ===');
      log(e.response?.data.toString() ?? 'Unknown error');
      log('=============================');
      throw Exception('Failed to add assignment: ${e.message}');
    }
  }

  @override
  Future<List<dynamic>> getReviewsByTrackId(String trackId) async {
    try {
       log('REVIEWS URL: ${ApiEndpoint.adminSubmissionViewByTrackId}');
    log('REVIEWS trackId: $trackId');
      final response = await ApiClient.get(
        path: ApiEndpoint.adminSubmissionViewByTrackId,
        queryParameters: {'trackId': trackId},
      );
       log('RAW REVIEWS: ${response.data}');
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      log('=== BACKEND ERROR MESSAGE ===');
      log(e.response?.data.toString() ?? 'Unknown error');
      log('=============================');
      throw Exception('Failed to load reviews: ${e.message}');
    }
  }

  @override
  Future<void> addSession(
    String trackId,
    String sessionLeaderId,
    String sessionName,
    String sessionDescription,
    String sessionDate,
    String sessionTime,
    String duration,
    String resourse,
  ) async {
    try {
       await ApiClient.post(
        path: ApiEndpoint.createSession,
        data: {
          'trackId': int.parse(trackId),
          'sessionLeaderID': sessionLeaderId,
          'title': sessionName,
          'description': sessionDescription,
          'date': sessionDate,
          'time': sessionTime,
          'duration': int.parse(duration),
          'resources': resourse,
        },
      );
    } on DioException catch (e) {
      log('=== BACKEND ERROR MESSAGE ===');
      log(e.response?.data.toString() ?? 'Unknown error');
      log('=============================');
      throw Exception('Failed to add session: ${e.message}');
    }
  }
}
