class AddScore {
  final int submissionId;
  final String nameOfReviwer;
  final num score;
  final String feedback;
  final DateTime submissionDate;

  AddScore({
    required this.submissionId,
    required this.score,
    required this.feedback,
    required this.submissionDate,
    required this.nameOfReviwer,
  });

  Map<String, dynamic> toJson() => {
    'submissionId': submissionId,
    'score': score,
    'feedback': feedback,
    'createdAt': submissionDate,
    'senderId': nameOfReviwer,
  };
}
