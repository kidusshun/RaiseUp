// import 'package:flutter/material.dart';

class TechnicianAppointments{
  DateTime time;
  String name;
  int customer_id;
  int appointmentId;
  String status;

  TechnicianAppointments({required this.time,required this.name,required this.customer_id,required this.appointmentId,required this.status});

  // Map<String, dynamic> toJson() {
  //   return {
  //     'time': time,
  //     'name': name,
  //     'customerId':customer_id,
  //   };
  // }

  factory TechnicianAppointments.fromJson(Map<String, dynamic> json) {
    return TechnicianAppointments(
      name: json['customer']['name'],
      time: DateTime.parse(json['time']),
      customer_id:json['customer']['id'],
      appointmentId: json['id'],
      status:"approved",
    );
  }
}

