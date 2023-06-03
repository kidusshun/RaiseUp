import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:raise_up/customers/customer_technician_list/model/customer_service_request_model.dart';

abstract class CustomerDateSeclectionRepository{
  Future<String> setDate(CustomerServiceRequest request);
}

class CustomerDateSeclectionRepositoryImpl extends CustomerDateSeclectionRepository {
  Future<String> setDate(CustomerServiceRequest request)async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "may");
    // print(jsonEncode(technicianInformationCredential.toJson()));
    // print(a);
    try{
      final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/service-request/create'),
      body: jsonEncode(request.toJson()), 
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    // print(response.statusCode);
    if (response.statusCode == 201) {
      // print(response.body);
      // print(token);
      // print("suces");
      return "Successfully Recoreded!";
    } else {
      // print("failure");
      return ('Failed to Record Credential');
    }
    }
    catch(error){
      return error.toString();
    }
    
  }

}