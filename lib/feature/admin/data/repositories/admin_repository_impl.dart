import 'dart:developer';

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
}
