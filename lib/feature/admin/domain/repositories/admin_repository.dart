import '../../../../core/models/session_model.dart';
import '../../data/models/admin_dashboard.dart';

abstract class AdminRepository {
 Future<AdminDashboard> getDashboard(String trackId);
 Future<List<SessionModel>> getSessionByTrackId(String trackId);

}