import 'package:flutter/material.dart';

class CustomerAppointments {
  DateTime time;
  String name;
  int customer_id;

  CustomerAppointments(
      {required this.time, required this.name, required this.customer_id});

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'notes': name,
      'customerId': customer_id,
    };
  }

  factory CustomerAppointments.fromJson(Map<String, dynamic> json) {
    return CustomerAppointments(
      name: json['customer']['name'],
      time: DateTime.parse(json['time']),
      customer_id: json['customer']['id'],
    );
  }
}
