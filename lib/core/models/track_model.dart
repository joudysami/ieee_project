import 'dart:convert';

class TrackModel {
  final int trackId;
  final String? name;
  final String? description;
  final String? meeting;

  TrackModel({
    required this.trackId,
    this.name,
    this.description,
    this.meeting,
  });

  Map<String, dynamic> toMap() {
    return {
      'trackId': trackId,
      'name': name,
      'description': description,
      'meeting': meeting,
    };
  }

  factory TrackModel.fromMap(Map<String, dynamic> map) {
    return TrackModel(
      trackId: map['trackId']?.toInt() ?? 0,
      name: map['name'],
      description: map['description'],
      meeting: map['meeting'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory TrackModel.fromJson(String source) =>
      TrackModel.fromMap(jsonDecode(source));
}