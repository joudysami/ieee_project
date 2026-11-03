part of 'admin_cubit.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminDashboardLoaded extends AdminState {
  final AdminDashboard dashboard;
  AdminDashboardLoaded(this.dashboard);
}

class AdminSessionsLoaded extends AdminState {
  final List<SessionModel> sessions;
  AdminSessionsLoaded(this.sessions);
}

class AdminAssignmentsLoaded extends AdminState {
  final List<AssignmentModel> assignments;
  AdminAssignmentsLoaded(this.assignments);
}

class AdminAssignmentAdded extends AdminState {}

class AdminSessionAdded extends AdminState {}

class AdminError extends AdminState {
  final String message;
  AdminError(this.message);
}

class AdminReviewAssignmentsLoaded extends AdminState {
  final List<ReviewAssignmentModel> reviews;
  AdminReviewAssignmentsLoaded(this.reviews);
}

class AdminScoreAdded extends AdminState {}

class AdminStudentsLoaded extends AdminState {
  final List<TrackStudent> students;
  AdminStudentsLoaded(this.students);
}
