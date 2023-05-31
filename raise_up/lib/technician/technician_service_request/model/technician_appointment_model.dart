import 'package:flutter/material.dart';

class TechnicianAppointment{
  String time;
  String notes;
  int customer_id;

  TechnicianAppointment({required this.time,required this.notes,required this.customer_id});

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'notes': notes,
      'customerId':customer_id,
    };
  }
}