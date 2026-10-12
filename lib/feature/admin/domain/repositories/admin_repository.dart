import 'package:ieee/feature/admin/data/models/add_score_model.dart';
import 'package:ieee/feature/admin/data/models/create_session_model.dart';
import 'package:ieee/feature/admin/data/models/review_ass_model.dart';

import '../../../../core/models/session_model.dart';
import '../../data/models/add_assignment_model.dart';
import '../../data/models/admin_dashboard.dart';

abstract class AdminRepository {
  Future<AdminDashboard> getDashboard(String trackId);
  Future<List<SessionModel>> getSessionByTrackId(String trackId);
  Future<void> addAssignment(AddAssignment assignment);
  Future<void> addSession(CreateSession session);
  Future<void> addFeedback(AddScore score);
  Future<List<ReviewAssignmentModel>> getReviewAssignments(String trackId);
}
