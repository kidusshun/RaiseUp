import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/customer_appointments_model.dart';

abstract class CustomerAppointmentsRepository {
  Future<void> getAppointments();
}

class CustomerAppointmentsRepositoryImpl
    extends CustomerAppointmentsRepository {
  @override
  Future<List<dynamic>> getAppointments() async {
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: "mayweather");
    // print(token);
    // print(a);
    final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/service-request/appointments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        });
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<CustomerAppointments> technicianList = [];
        body.forEach((element) {
          technicianList.add(CustomerAppointments.fromJson(element));
        });
        // print(technicianList.length);
        return technicianList;
      } else {
        return (['Failed to to get appointments']);
      }
    } catch (e) {
      return [e];
    }
  }
}
