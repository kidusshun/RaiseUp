import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:raise_up/customers/app_route_customers.dart';
import 'package:raise_up/landing/ui/landing_page.dart';
import 'package:raise_up/technician/app_route.dart';
import 'package:raise_up/technician/technician_account_information/ui/technician_account_information.dart';
import 'package:raise_up/technician/technician_signin/ui/technician_signin.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: TechnicianRouter().router.routeInformationParser,
      routerDelegate: TechnicianRouter().router.routerDelegate,
      backButtonDispatcher: RootBackButtonDispatcher(),
    );
  }
}
