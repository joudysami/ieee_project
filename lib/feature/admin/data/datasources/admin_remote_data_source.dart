import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../core/constant/api_endpoint.dart';
import '../../../../core/network/api_client.dart';

abstract class AdminRemoteDataSource {
  Future<Map<String, dynamic>> getDashboard(String trackId);
  Future<List<dynamic>> getSessionByTrackId(String trackId);
  Future<void> addAssignment(Map<String, dynamic> body);
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
}
