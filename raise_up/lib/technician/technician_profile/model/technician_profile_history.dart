class ProfileHistory {
  final String name;
  final DateTime dateTime;

  ProfileHistory({
    required this.name,
    required this.dateTime,
  });

  factory ProfileHistory.fromJson(Map<String, dynamic> json) {
    return ProfileHistory(
      name: json['name'],
      dateTime: DateTime.parse(json['date']),
    );
  }
}
