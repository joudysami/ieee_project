import 'package:bloc/bloc.dart';
import 'package:ieee/feature/admin/data/models/admin_dashboard.dart';
import 'package:ieee/feature/admin/domain/repositories/admin_repository.dart';

import '../../../../core/models/session_model.dart';
part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository repository;
  AdminCubit({required this.repository}) : super(AdminInitial());

  Future<void> loadDashboard(String trackId) async {
    emit(AdminLoading());
    try {
      final dashboardData = await repository.getDashboard(trackId);

      emit(AdminDashboardLoaded(dashboardData));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> loadSessionsByTrackId(String trackId) async {
    emit(AdminLoading());
    try {
      final sessions = await repository.getSessionByTrackId(trackId);
      print('SESSIONS COUNT: ${sessions.length} for track $trackId');
      emit(AdminSessionsLoaded(sessions));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

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
    emit(AdminLoading());
    try {
       await repository.addSession(
        trackId,
        sessionLeaderId,
        sessionName,
        sessionDescription,
        sessionDate,
        sessionTime,
        duration,
        resourse
      );
      emit(AdminSessionAdded()); // Assuming the first session is the one that was added
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }
}
