import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/customer_credential_model.dart';


abstract class CustomerCredentialRepository {
  Future<String> createCustomerUser(
      CustomerCredential customerCredential);
}

class CustomerCredentialRepositoryimpl
    implements CustomerCredentialRepository {
  @override
  Future<String> createCustomerUser(
      CustomerCredential customerCredential) async {
    // print(customerCredential.email);
    final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/customer/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            customerCredential.toJson()) // Convert the user object to JSON
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
