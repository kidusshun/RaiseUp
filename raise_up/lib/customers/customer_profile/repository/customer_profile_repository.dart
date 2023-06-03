import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:raise_up/technician/technician_profile/model/technician_profile_class.dart';

import '../model/customerProfileNameModel.dart';
import '../model/customer_profile_history.dart';


abstract class CustomerProfileRepository{
  Future<dynamic> getHistory();
  Future<dynamic> getCustomerName();
}
class CustomerProfileRepositoryImpl extends CustomerProfileRepository{
  @override
  Future<dynamic> getHistory() async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "may");
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/service-request/past'),
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    try{
      if (response.statusCode == 200 && response.body.isNotEmpty) {
      List<dynamic> body=json.decode(response.body);
      List<CustomerProfileHistory> technicianList=[];
      body.forEach((element) { 
        technicianList.add(CustomerProfileHistory.fromJson(element));
      });
      return technicianList;
    } else if(response.body.isNotEmpty) {
      return (['Failed to Load History']);
    }else if(response.body.isEmpty){
      return ['No History'];
    }
    }
    catch(e){
      return e;
    }
  }
  @override
  Future<dynamic> getCustomerName() async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "may");
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/customer-profile'),
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    try{
      if (response.statusCode == 200) {
        CustomerProfileName customerName=CustomerProfileName.fromJson(json.decode(response.body));
        return customerName.name;
    } else{
      return "None";
    }
    }
    catch(e){
      return e;
    }
  }
  }
