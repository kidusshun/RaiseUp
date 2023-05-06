import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:raise_up/pages/technician_signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wheels',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // Add this line to center the label text horizontally inside the circular border
        inputDecorationTheme: InputDecorationTheme(
          alignLabelWithHint: true,
        ),
      ),
      home: SignupPage(),
    );
  }
}
