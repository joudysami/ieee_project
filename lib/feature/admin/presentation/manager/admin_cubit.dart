import 'package:bloc/bloc.dart';
import 'package:ieee/feature/admin/data/models/admin_dashboard.dart';
import 'package:ieee/feature/admin/domain/repositories/admin_repository.dart';

import '../../../../core/models/session_model.dart';
import '../../data/models/add_assignment_model.dart';
part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository repository;
  AdminCubit({required this.repository}) : super(AdminInitial());

  bool _hasNoTrack(String trackId) {
    if (trackId.isEmpty || trackId == 'null') {
      emit(
        AdminError('This account has no track assigned. Please log in again.'),
      );
      return true;
    }
    return false;
  }

  Future<void> loadDashboard(String trackId) async {
    if (_hasNoTrack(trackId)) return;

    emit(AdminLoading());
    try {
      final dashboardData = await repository.getDashboard(trackId);

      emit(AdminDashboardLoaded(dashboardData));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> loadSessionsByTrackId(String trackId) async {
    if (_hasNoTrack(trackId)) return;

    emit(AdminLoading());
    try {
      final sessions = await repository.getSessionByTrackId(trackId);
      emit(AdminSessionsLoaded(sessions));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> addAssignment(AddAssignment assignment) async {
    emit(AdminLoading());
    try {
      await repository.addAssignment(assignment);
      emit(AdminAssignmentAdded());
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }
}
