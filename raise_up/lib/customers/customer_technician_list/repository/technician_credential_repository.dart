// import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/technician_credential_model.dart';


abstract class TechnicianCredentialRepository {
  Future<List<dynamic>> getTechnicians();
}

class TechnicianCredentialRepositoryImpl implements TechnicianCredentialRepository{
  @override
  Future<List<dynamic>> getTechnicians() async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "may");
    // print(token);
    // print(a);
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/customer-profile/getAllTechnician'),
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    try{
      if (response.statusCode == 200) {
      List<dynamic> body=json.decode(response.body);
      List<TechnicianCredential> technicianList=[];
      body.forEach((element) { 
        technicianList.add(TechnicianCredential.fromJson(element));
      });
      return technicianList;
    } else {
      // Handle error response
      return (['Failed to Appoint Customer']);
    }
    }
    catch(e){
      return [e];
    }
  }
  
}

