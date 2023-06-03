import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:raise_up/customers/customer_service_request/model/customer_service_request_model.dart';


abstract class CustomerServiceRequestRepository{
  Future<List<dynamic>> getServiceRequests();
}

class CustomerServiceRequestRepositoryImpl extends CustomerServiceRequestRepository{
  @override
  Future<List<dynamic>> getServiceRequests() async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "may");
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/service-request/pending'),
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    // print(response.statusCode);
    // print(response.body);
    try{
      if (response.statusCode == 200) {
      List<dynamic> body=json.decode(response.body);
      List<CustomerServiceRequestModel> technicianList=[];
      body.forEach((element) { 
        technicianList.add(CustomerServiceRequestModel.fromJson(element));
      });
      // print(technicianList);
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