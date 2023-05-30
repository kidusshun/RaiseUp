import 'package:flutter/material.dart';

class TechnicianAppointment{
  TimeOfDay time;
  String notes;
  int customer_id;

  TechnicianAppointment({required this.time,required this.notes,required this.customer_id});

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'notes': notes,
      'customer_id':customer_id,
    };
  }
}