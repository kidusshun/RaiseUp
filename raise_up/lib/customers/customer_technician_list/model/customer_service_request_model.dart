import 'package:intl/intl.dart';

class CustomerServiceRequest{
  String isoDateString;
  String notes;
  int technicianId;
  CustomerServiceRequest({required this.isoDateString,required this.notes, required this.technicianId,});

  void IsoConvertor(DateTime dateAndTime){
    
  }

  Map<String,dynamic> toJson(){
    return {
      'preferredDate':isoDateString,
      'notes':notes,
      'technicianId':technicianId,
    };
  }
}