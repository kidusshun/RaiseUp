class TechnicianProfile {
  final String name;
  final String phoneNumber;
  final List<String> skills;
  final List<ContactInfo> history;

  TechnicianProfile({
    required this.name,
    required this.phoneNumber,
    required this.skills,
    required this.history,
  });

  factory TechnicianProfile.fromJson(Map<String, dynamic> json) {
    List<dynamic> historyJson = json['history'];

    List<ContactInfo> history =
        historyJson.map((json) => ContactInfo.fromJson(json)).toList();

    return TechnicianProfile(
      name: json['name'].toString(),
      phoneNumber: json['phoneNumber'].toString(),
      skills: List<String>.from(json['skills']),
      history: history,
    );
  }
}

class ContactInfo {
  final String customerName;
  final String customerPhoneNumber;
  final String date;

  ContactInfo({
    required this.customerName,
    required this.customerPhoneNumber,
    required this.date,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      customerName: json['customerName'].toString(),
      customerPhoneNumber: json['customerPhoneNumber'].toString(),
      date: json['date'].toString(),
    );
  }
}
