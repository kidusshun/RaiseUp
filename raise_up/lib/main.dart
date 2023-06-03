import 'package:flutter/material.dart';
import 'landing/app_route_customers.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: LandingRouter().router.routeInformationParser,
      routerDelegate: LandingRouter().router.routerDelegate,
      backButtonDispatcher: RootBackButtonDispatcher(),
    );
  }
}
