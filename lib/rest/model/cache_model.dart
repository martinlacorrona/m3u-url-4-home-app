class CacheModel {
  final DateTime lastUpdate;

  const CacheModel({
    required this.lastUpdate,
  });

  factory CacheModel.fromJson(Map<String, dynamic> json) {
    return CacheModel(
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(json['lastUpdate']),
    );
  }
}