import '../../data/models/admin_dashboard.dart';

abstract class AdminRepository {
 Future<AdminDashboard> getDashboard(String trackId);
}