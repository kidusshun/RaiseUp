import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:raise_up/technician/technician_profile/model/technician_profile_class.dart';

import '../model/technicianProfileNameModel.dart';
import '../model/technician_profile_history.dart';

abstract class TechnicianProfileRepository{
  Future<dynamic> getHistory();
  Future<dynamic> getTechnicianName();
}
class TechnicianProfileRepositoryImpl extends TechnicianProfileRepository{
  @override
  Future<dynamic> getHistory() async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "money");
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/appointments/past'),
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    try{
      if (response.statusCode == 200 && response.body.isNotEmpty) {
      List<dynamic> body=json.decode(response.body);
      List<ProfileHistory> technicianList=[];
      body.forEach((element) { 
        technicianList.add(ProfileHistory.fromJson(element));
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
  Future<dynamic> getTechnicianName() async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "money");
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/technician-profile/getTechnician'),
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    try{
      if (response.statusCode == 200) {
        TechnicianProfileName technicianName=TechnicianProfileName.fromJson(json.decode(response.body));
        return technicianName.name;
    } else{
      return "None";
    }
    }
    catch(e){
      return e;
    }
  }
  }
