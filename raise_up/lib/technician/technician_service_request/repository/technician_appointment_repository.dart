import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
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
    print(response.statusCode);
    if (response.statusCode == 201) {
      // Successful response
      final responseData = json.decode(response.body);
      // print(responseData);

      DateTime dateTime = DateTime.parse(responseData['time']);
      
      String date = DateFormat('yyyy-MM-dd').format(dateTime);

      // Extract time in 12-hour format with AM/PM
      String time = DateFormat('hh:mm a').format(dateTime);

      print(date);
      print(time);

      return "Successfully Appointed!";
    } else {
      // Handle error response
      return ('Failed to Appoint Customer');
    }
  }
  
}

