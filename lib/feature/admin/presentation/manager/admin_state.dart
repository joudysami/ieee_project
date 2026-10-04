part of 'admin_cubit.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminDashboardLoaded extends AdminState {
  final AdminDashboard dashboard;
  AdminDashboardLoaded(this.dashboard);
}

class AdminError extends AdminState {
  final String message;
  AdminError(this.message);
}
