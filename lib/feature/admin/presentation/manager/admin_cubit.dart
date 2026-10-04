import 'package:bloc/bloc.dart';
import 'package:ieee/feature/admin/data/models/admin_dashboard.dart';
import 'package:ieee/feature/admin/domain/repositories/admin_repository.dart';
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
}
