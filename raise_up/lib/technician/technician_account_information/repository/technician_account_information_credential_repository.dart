import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/technician_account_information_credential_model.dart';

abstract class TechnicianAccountInformationCredentialRepository{
  Future<void> updateInformation(TechnicianAccountInformationCredential informationCredential);
}

class TechnicianAccountInformationCredentialRepositoryImpl extends TechnicianAccountInformationCredentialRepository {
  Future<String> updateInformation(TechnicianAccountInformationCredential technicianInformationCredential ) async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "money");

    try{
      final response = await http.patch(
      Uri.parse('http://10.0.2.2:3000/technician-profile'),
      body: jsonEncode(technicianInformationCredential.toJson()), 
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    if (response.statusCode == 200) {
      return "Successfully Recoreded!";
    } else {
      return ('Failed to Record Credential');
    }
    }
    catch(error){
      return error.toString();
    }
    
  }

}