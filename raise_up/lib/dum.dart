import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TechnicianAppointmentRepositoryimpl extends StatefulWidget{
  @override
  Future<String> createAppointment() async {
    // final storage= new FlutterSecureStorage();
    // String? a = await storage.read(key: "money");
    // print(a);
    String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjUwLCJlbWFpbCI6ImVwZGVtcmV3QGdtYWlsLmNvbSIsImlhdCI6MTY4NTQzNzU5M30.cXtTX-v2vvOrvCHchebpzK1XqUBeg2yc42bu203tr5M";
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/appointments/create'),
      body: {
        'time':'12 AM',
        'notes':'engine faliure',
        'customerId':'1',
      },//json.encode(appointment.toJson()), // Convert the user object to JSON
      headers:{
        'Authorization':'Bearer $token'
      }
    );

    if (response.statusCode == 201) {
      // Successful response
      final responseData = json.decode(response.body);
      return "Successfully Appointed!";
    } else {
      // Handle error response
      throw Exception('Failed to Appoint Customer');
    }
  }
  Future<Widget> builder(BuildContext,context) async {
    print(await createAppointment());
    return Scaffold();
  }
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}