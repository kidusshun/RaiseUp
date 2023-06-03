import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/customer_service_request_delete_model.dart';

abstract class CustomerServiceRequestDeleteRepository{
  Future<dynamic> deleteAppointment(CustomerServiceRequestDelete serviceRequest);
}

class CustomerServiceRequestDeleteRepositoryImpl{
  @override
  Future<dynamic> deleteAppointment(CustomerServiceRequestDelete serviceRequest) async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "may");
    dynamic response= await http.delete(
      Uri.parse('http://10.0.2.2:3000/service-request/DeleteServiceRequestForCustomer'),
      headers: {
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      },
      body:json.encode(serviceRequest.toJson()),
    );
    if (response.statusCode==200){
      return "Sucessfully Deleted";
    }else{
      return "Failed to Delete";
    }
  }
}