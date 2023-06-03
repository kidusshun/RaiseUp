class TechnicianProfileName{
  String name;
  TechnicianProfileName({required this.name});


  factory TechnicianProfileName.fromJson(Map<String, dynamic> json) {
    return TechnicianProfileName(
      name: json['name'],
    );
  }

}