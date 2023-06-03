import 'package:flutter/material.dart';

class CustomerAppointments {
  DateTime time;
  String name;
  int technicianId;
  String phone;
  String location;
  int appointmentId;

  CustomerAppointments(
      {required this.time, required this.name, required this.technicianId,required this.location,required this.phone,required this.appointmentId});

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'notes': name,
      'technicianId': technicianId,
    };
  }

  factory CustomerAppointments.fromJson(Map<String, dynamic> json) {
    return CustomerAppointments(
      name: json['technician']['name'],
      time: DateTime.parse(json['time']),
      technicianId: json['technician']['id'],
      phone: json['technician']['phone'],
      location: json['technician']['location'],
      appointmentId: json['id']
    );
  }
}
