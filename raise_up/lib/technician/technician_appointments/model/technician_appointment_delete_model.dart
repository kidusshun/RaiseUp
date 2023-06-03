class TechnicianAppointmentDelete{
  int appointmentId;
  TechnicianAppointmentDelete({required this.appointmentId});

  Map<String,dynamic> toJson(){
    return {
      "appointmentId":appointmentId,
    };
  }
}