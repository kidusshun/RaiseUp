import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import'package:http/http.dart' as http;
import 'package:raise_up/technician/technician_appointments/model/technician_appointments_update_model.dart';
abstract class TechnicianAppointmentsUpdateRepository{
  Future<String> updateAppointments(TechnicianAppointmentsUpdate appointment);
}
class TechnicianAppointmentsUpdateRepositoryImpl extends TechnicianAppointmentsUpdateRepository{
  @override
  Future<String> updateAppointments(TechnicianAppointmentsUpdate appointment) async{
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "money");
    dynamic response = await http.patch(
      Uri.parse('http://10.0.2.2:3000/appointments'),
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      },
      body:json.encode(appointment.toJson())
      
    );
    if (response.statusCode==200){
      return "Sucessfully Updated";
    }else{
      return "Failed to Update";
    }
  }
}