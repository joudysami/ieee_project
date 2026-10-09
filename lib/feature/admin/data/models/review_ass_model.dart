class ReviewAssignmentModel {
  final int submissionId;
  final String submissionUrl;
  final String submissionState;
  final String assignmentTitle;
  final String studentName;

  ReviewAssignmentModel({
    required this.submissionId,
    required this.submissionUrl,
    required this.submissionState,
    required this.assignmentTitle,
    required this.studentName,
  });

  factory ReviewAssignmentModel.fromMap(Map<String, dynamic> json) =>
      ReviewAssignmentModel(
        submissionId: json['submissionId'] ?? 0,
        submissionUrl: json['submissionUrl'] ?? '',
        submissionState: json['submissionStatus'] ?? '',
        assignmentTitle: json['assignmenttitle'] ?? '',
        studentName: json['studentName'] ?? '',
      );

  Map<String, dynamic> toMap() => {
    'submissionId': submissionId,
    'submissionUrl': submissionUrl,
    'submissionStatus': submissionState,
    'assignmenttitle': assignmentTitle,
    'studentName': studentName,
  };
}
