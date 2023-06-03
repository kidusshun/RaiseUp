class TechnicianAppointmentStatus{
  int serviceId;
  String status;
  TechnicianAppointmentStatus({required this.serviceId,required this.status});

  Map<String,dynamic> toJson(){
    return {
      'serviceId':this.serviceId,
      'status':"approved",
    };
  }
}