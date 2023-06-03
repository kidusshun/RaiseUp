class TechnicianCredential{
  List<String> expertise;
  String garage;
  String location;
  String name;
  int id;

  TechnicianCredential({required this.expertise,required this.garage,required this.location,required this.name,required this.id});

  factory TechnicianCredential.fromJson(Map<String, dynamic> json) {
    List<String> expertiseList=[];
    json['expertise'].forEach((value){
      expertiseList.add(value['name']);
    });
    return TechnicianCredential(
      expertise: expertiseList,
      garage: json['garage'],
      location: json['location'],
      name: json['name'],
      id:json['id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expertise': expertise,
      'garage': garage,
      'location': location,
      'name':name,
      'id':id,
    };
  }
}

