import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:raise_up/technician/technician_signin/ui/technician_signin.dart';
// import 'package:raise_up/technician/technician_signup/ui/technician_signup.dart';
import 'package:raise_up/technician/technician_signup/ui/technician_signup.dart';
import 'package:raise_up/customers/customer_technician_list/ui/customer_technician.dart';
import 'technician/technician_profile/ui/technician_profile.dart';
import 'technician/technician_service_request/ui/technician_service_request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TechnicianSignin(),
    );
  }
}
