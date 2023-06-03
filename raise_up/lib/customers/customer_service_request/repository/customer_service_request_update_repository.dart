import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/customer_service_request_update_model.dart';


abstract class CustomerServiceRequestUpdateRepository{
  Future<String> updateServiceRequests(CustomerServiceRequestUpdate serviceRequest);
}
class CustomerServiceRequestUpdateRepositoryImpl extends CustomerServiceRequestUpdateRepository{
  @override
  Future<String> updateServiceRequests(CustomerServiceRequestUpdate serviceRequest) async{
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "may");
    dynamic response = await http.patch(
      Uri.parse('http://10.0.2.2:3000/service-request/EditServiceRequestsForCustomer'),
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      },
      body:json.encode(serviceRequest.toJson())
      
    );
    if (response.statusCode==200){
      return "Sucessfully Updated";
    }else{
      return "Failed to Update";
    }
  }
}