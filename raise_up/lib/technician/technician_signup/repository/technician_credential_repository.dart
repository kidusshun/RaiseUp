import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:raise_up/technician/technician_signup/model/technician_credential_model.dart';

abstract class TechnicianCredentialRepository {
  Future<String> createTechnicianUser(
      TechnicianCredential technicianCredential);
}

class TechnicianCredentialRepositoryimpl
    implements TechnicianCredentialRepository {
  @override
  Future<String> createTechnicianUser(
      TechnicianCredential technicianCredential) async {
    // print(technicianCredential.email);
    final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/technician/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            technicianCredential.toJson()) // Convert the user object to JSON
        );
    // print(response);
    // print(response.body);
    if (response.statusCode == 201) {
      // Successful response
      final responseData = json.decode(response.body);
      return ("Created Successfully");
      // print('token: ${response.body}');
    } else if (response.statusCode == 403) {
      // Handle error response
      // print('Error: ${response.statusCode}');
      return ("Account with this email already exists");
    } else if (response.statusCode == 400) {
      return ("Use a correct email");
    }
    return "Unknown Problem occured please try again later";
  }
}
