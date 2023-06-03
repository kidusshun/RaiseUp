import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:raise_up/technician/technician_appointments/model/technician_appointment_delete_model.dart';

abstract class TechnicianAppointmentDeleteRepository{
  Future<dynamic> deleteAppointment(TechnicianAppointmentDelete appointment);
}

class TechnicianAppointmentDeleteRepositoryImpl{
  @override
  Future<dynamic> deleteAppointment(TechnicianAppointmentDelete appointment) async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "money");
    dynamic response= await http.delete(
      Uri.parse('http://10.0.2.2:3000/appointments'),
      headers: {
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      },
      body:json.encode(appointment.toJson()),
    );
    if (response.statusCode==200){
      return "Sucessfully Deleted";
    }else{
      return "Failed to Delete";
    }
  }
}