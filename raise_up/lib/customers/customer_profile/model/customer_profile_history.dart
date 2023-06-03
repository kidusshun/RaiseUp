class CustomerProfileHistory {
  final String name;
  final DateTime dateTime;

  CustomerProfileHistory({
    required this.name,
    required this.dateTime,
  });

  factory CustomerProfileHistory.fromJson(Map<String, dynamic> json) {
    return CustomerProfileHistory(
      name: json['name'],
      dateTime: DateTime.parse(json['date']),
    );
  }
}
