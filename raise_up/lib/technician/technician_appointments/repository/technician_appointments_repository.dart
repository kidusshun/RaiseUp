import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/technician_appointments_model.dart';
abstract class TechnicianAppointmentsRepository{
  Future<void> getAppointments();
}
class TechnicianAppointmentsRepositoryImpl extends TechnicianAppointmentsRepository{
  @override
  Future<List<dynamic>> getAppointments() async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "money");
    // print(token);
    // print(a);
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/appointments'),
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    try{
      if (response.statusCode == 200) {

      List<dynamic> body=json.decode(response.body);
      List<TechnicianAppointments> technicianList=[];
      body.forEach((element) { 
        technicianList.add(TechnicianAppointments.fromJson(element));
      });
      // print(technicianList.length);
      return technicianList;
    } else {
      return (['Failed to Appoint Customer']);
    }
    }
    catch(e){
      return [e];
    }
  }
}