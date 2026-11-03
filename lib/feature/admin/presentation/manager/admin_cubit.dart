import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:ieee/feature/admin/data/models/admin_dashboard.dart';
import 'package:ieee/feature/admin/data/models/track_student.dart';
import 'package:ieee/feature/admin/domain/repositories/admin_repository.dart';
import '../../../../core/models/assignment_model.dart';
import '../../../../core/models/session_model.dart';
import '../../data/models/add_assignment_model.dart';
import '../../data/models/add_score_model.dart';
import '../../data/models/create_session_model.dart';
import '../../data/models/review_ass_model.dart';
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
      print('SESSIONS COUNT: ${sessions.length} for track $trackId');
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

  Future<void> addSession(CreateSession session) async {
    emit(AdminLoading());
    try {
      await repository.addSession(session);
      emit(
        AdminSessionAdded(),
      ); // Assuming the first session is the one that was added
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> loadAssignmentsByTrackId(String trackId) async {
    if (_hasNoTrack(trackId)) return;

    emit(AdminLoading());
    try {
      final assignments = await repository.getAssignmentsByTrackId(trackId);
      log('Assignments COUNT: ${assignments.length} for track $trackId');
      emit(AdminAssignmentsLoaded(assignments));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> loadReviewAssignments(String trackId) async {
    if (_hasNoTrack(trackId)) return;

    emit(AdminLoading());
    try {
      final reviews = await repository.getReviewAssignments(trackId);
      emit(AdminReviewAssignmentsLoaded(reviews));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> addFeedback(AddScore score) async {
    emit(AdminLoading());
    try {
      await repository.addFeedback(score);
      emit(AdminScoreAdded());
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> loadStudentsByTrackId(String trackId) async {
    if (_hasNoTrack(trackId)) return;

    emit(AdminLoading());
    try {
      final students = await repository.getAllStudentsByTrackId(trackId);
      log('Students COUNT: ${students.length} for track $trackId');
      emit(AdminStudentsLoaded(students));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }
}
