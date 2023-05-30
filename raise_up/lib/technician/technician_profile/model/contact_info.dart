class ContactInfo {
  final String name;
  final String phonenumber;

  ContactInfo({
    required this.name,
    required this.phonenumber,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      name: json['name'].toString(),
      phonenumber: json['phonenumber'].toString(),
    );
  }
}
