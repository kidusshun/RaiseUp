import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/technician_customer_service_request.dart';




abstract class TechnicianCustomerServiceRequestRepository {
  Future<dynamic> getCustomers();
}

class TechnicianCustomerServiceRequestRepositoryImpl implements TechnicianCustomerServiceRequestRepository{
  @override
  Future<List<dynamic>> getCustomers() async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "money");
    // print(token);
    // print(a);
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/appointments/pending'),
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    try{
      if (response.statusCode == 200) {

      List<dynamic> body=json.decode(response.body);
      List<TechnicianCustomerServiceRequest> technicianList=[];
      body.forEach((element) { 
        technicianList.add(TechnicianCustomerServiceRequest.fromJson(element));
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
