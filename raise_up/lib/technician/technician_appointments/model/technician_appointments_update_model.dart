class TechnicianAppointmentsUpdate{
  String time;
  int appointmentId;
  String status;
  TechnicianAppointmentsUpdate({required this.time,required this.appointmentId,required this.status});

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'appointmentId': appointmentId,
      'status':status,
    };
  }
}
  // factory TechnicianCustomerServiceRequest.fromJson(Map<String, dynamic> json) {
  //   return TechnicianCustomerServiceRequest(
  //     name: json['customer']['name'],
  //     date: DateTime.parse(json['preferredDate']),
  //     customerId:json['customer']['id'],
  //     serviceId:json['id'],
  //     status:json['status'],
  //   );
  // }
