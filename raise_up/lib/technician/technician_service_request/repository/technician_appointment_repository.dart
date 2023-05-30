

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


abstract class TechnicianAppointmentRepository {
  Future<String> createAppointment(TechnicianAppointment appointment);
}

class TechnicianAppointmentRepositoryimpl implements TechnicianAppointmentRepository{
  @override
  Future<String> createAppointment(TechnicianAppointment appointment) async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "money");
    // print(a);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/appointments/create'),
      body: jsonEncode(appointment.toJson()), // Convert the user object to JSON
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );

    if (response.statusCode == 201) {
      // Successful response
      final responseData = json.decode(response.body);
      print(responseData['time']);
      return "Successfully Appointed!";
    } else {
      // Handle error response
      throw Exception('Failed to Appoint Customer');
    }
    
    // String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjUwLCJlbWFpbCI6ImVwZGVtcmV3QGdtYWlsLmNvbSIsImlhdCI6MTY4NTQzNzU5M30.cXtTX-v2vvOrvCHchebpzK1XqUBeg2yc42bu203tr5M";
    // final response = await http.post(
    //   Uri.parse('http://10.0.2.2:3000/appointments/create'),
    //   body: jsonEncode({
    //     'time':'2023-05-30T08:23:19Z',
    //     'notes':'engine faliure',
    //     'customerId':1,
    //   }),//json.encode(appointment.toJson()), // Convert the user object to JSON
    //   headers:{
    //     'Authorization':'Bearer $token',
    //     'Content-Type': 'application/json',
    //   }
    // );

    // if (response.statusCode == 201) {
    //   // Successful response
    //   final responseData = json.decode(response.body);
    //   print(responseData);
    //   return "Successfully Appointed!";
    // } else {
    //   // Handle error response
    //   throw Exception('Failed to Appoint Customer');
    // }


  }
  
}

