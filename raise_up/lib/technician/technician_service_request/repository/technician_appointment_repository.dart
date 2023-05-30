import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


abstract class TechnicianAppointmentRepository {
  Future<String> createAppointment(TechnicianAppointment appointment);
}

class TechnicianAppointmentRepositoryimpl implements TechnicianAppointmentRepository{
  @override
  Future<String> createAppointment(TechnicianAppointment appointment) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/appointments/create'),
      body: appointment.toJson(), // Convert the user object to JSON
    );

    if (response.statusCode == 201) {
      // Successful response
      final responseData = json.decode(response.body);
      return "Successfully Appointed!";
    } else {
      // Handle error response
      throw Exception('Failed to Appoint Customer');
    }
  }
  
}

