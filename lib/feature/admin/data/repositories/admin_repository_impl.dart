import 'dart:developer';
import 'package:ieee/core/models/session_model.dart';
import 'package:ieee/feature/admin/data/models/admin_dashboard.dart';
import '../../domain/repositories/admin_repository.dart';
import '../datasources/admin_remote_data_source.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;
  AdminRepositoryImpl({required this.remoteDataSource});
  @override
  Future<AdminDashboard> getDashboard(String trackId) async {
    try {
      final rawData = await remoteDataSource.getDashboard(trackId);
      return AdminDashboard.fromMap(rawData);
    } catch (e) {
      log('=== REPOSITORY ERROR ===');
      log(e.toString());
      log('========================');
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<SessionModel>> getSessionByTrackId(String trackId) async {
    try {
      final rawData = await remoteDataSource.getSessionByTrackId(trackId);
      return rawData
          .map((e) => SessionModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('=== REPOSITORY ERROR ===');
      log(e.toString());
      log('========================');
      throw Exception(e.toString());
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
    String resourse
  ) async {
    try {
       await remoteDataSource.addSession(
        trackId,
        sessionLeaderId,
        sessionName,
        sessionDescription,
        sessionDate,
        sessionTime,
        duration,
        resourse
      );
    } catch (e) {
      log('=== REPOSITORY ERROR ===');
      log(e.toString());
      log('========================');
      throw Exception(e.toString());
    }
  }
}
