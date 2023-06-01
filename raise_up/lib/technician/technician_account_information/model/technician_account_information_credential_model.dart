
class TechnicianAccountInformationCredential{
  List<String> expertises;
  String phone;
  String garage;
  String location;

  TechnicianAccountInformationCredential({required this.expertises,required this.garage,required this.location,required this.phone});

  Map<String,dynamic> toJson(){
    return {
      'expertise':expertises,
      'phone':phone,
      'garage':garage,
      'location':location,
    };
  }
}