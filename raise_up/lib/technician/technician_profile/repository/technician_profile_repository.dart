import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:raise_up/technician/technician_profile/model/technician_profile_class.dart';

import '../model/technician_profile_history.dart';

abstract class TechnicianProfileRepository{}
class TechnicianProfileRepositoryImpl extends TechnicianProfileRepository{
  @override
  Future<void> getHistory() async {
    final storage= new FlutterSecureStorage();
    String? token = await storage.read(key: "money");
    // print(token);
    // print(a);
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/appointments/past'),
      headers:{
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      }
    );
    print(response.body);
  }
  //   try{
  //     if (response.statusCode == 200) {

  //     List<dynamic> body=json.decode(response.body);
  //     List<ProfileHistory> technicianList=[];
  //     body.forEach((element) { 
  //       technicianList.add(ProfileHistory.fromJson(element));
  //     });
  //     // print(technicianList[0].name);
  //     return technicianList;
  //   } else {
  //     return ('Failed to Appoint Customer');
  //   }
  //   }
  //   catch(e){
  //     return e;
  //   }
  // }
}
