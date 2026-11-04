/// Matches Swagger schema `StudentAllSubmissionView`.
class StudentSubmissionModel {
  final String? status;
  final double? score;
  final int assignmentId;

  StudentSubmissionModel({
    this.status,
    this.score,
    required this.assignmentId,
  });

  factory StudentSubmissionModel.fromMap(Map<String, dynamic> map) {
    return StudentSubmissionModel(
      status: map['status'] as String?,
      score: (map['score'] as num?)?.toDouble(),
      assignmentId: map['assignmentId']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'status': status,
    'score': score,
    'assignmentId': assignmentId,
  };
}
