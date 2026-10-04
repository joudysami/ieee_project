class ApiEndpoint {
  ApiEndpoint._();

  static const String baseUrl = "https://et5app.runasp.net";
  static const String registerWithToken = "/api/Auth/firebase-loginWithUID";
  static const String getAdminDashBoard = '/admindashboard';
  static const String getStudentDashBoard = '/studentdashboard';
  static const String addAssignment = '/AddAssignment';
  static const String updateAssignment  = '/UpdateAssignment';
  static const String deleteAssignment  = '/DeleteAssignment';
  static const String getAllAssignmentsByTrackId  = '/GetAllAssignmentsByTrackId';
  static const String postAttendance  = '/PostAttendance';
  static const String getAttendancesBySessionId  = '/GetAttendancesBySessionId';
  static const String getAttendanceByStudentId  = '/GetAttendanceByStudentId';
  static const String addFeedback  = '/AddFeedback';
  static const String getFeedbacksByUserId  = '/GetFeedbacksByUserId';
  static const String createSession  = '/CreateSession';
  static const String editSession  = '/EditSession';
  static const String deleteSession  = '/DeleteSession';
  static const String sessionsByTrackID  = '/SessionsByTrackID';
  static const String sessionsById  = '/SessionsById';
  static const String getAllByTrackID  = '/GetAllByTrackID';
  static const String getStudentByName  = '/GetStudentByName';
  static const String deleteStudent  = '/DeleteStudent';
  static const String studentAddSubmission  = '/api/Submission/StudentAddSubmission';
  static const String updateStudentSubmission  = '/api/Submission/UpdateStudentSubmission';
  static const String adminSubmissionViewByAssignmentId  = '/api/Submission/AdminSubmissionView/{assignmentId}';
  static const String adminSubmissionViewByTrackId  = '/api/Submission/AdminSubmissionViewById/{TrackId}';
  static const String adminAddScore  = '/api/Submission/AdminAddScore';
  static const String studentAllSubmissionByUserId  = '/api/Submission/StudentAllSubmission/{userId}';
  static const String allTracks  = '/Get all tracks';
  static const String trackById  = '/Get track by id';
  static const String viewUserInfo  = '/ViewUserInfo';



}
