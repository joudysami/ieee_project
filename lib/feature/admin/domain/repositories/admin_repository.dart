import 'package:ieee/feature/admin/data/models/review_ass_model.dart';

import '../../../../core/models/session_model.dart';
import '../../data/models/add_assignment_model.dart';
import '../../data/models/admin_dashboard.dart';

abstract class AdminRepository {
 Future<AdminDashboard> getDashboard(String trackId);
 Future<List<SessionModel>> getSessionByTrackId(String trackId);
 Future<void> addAssignment(AddAssignment assignment);
 Future<void> addSession(
   String trackId,
   String sessionLeaderId,
   String sessionName,
   String sessionDescription,
   String sessionDate,
   String sessionTime,
   String duration,
   String resourse
 );
 Future<List<ReviewAssignmentModel>> getReviewAssignments(String trackId);
}