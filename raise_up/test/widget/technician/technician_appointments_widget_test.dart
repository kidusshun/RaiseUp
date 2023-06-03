import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/technician/technician_appointments/bloc/technician_appointments_bloc.dart';
import 'package:raise_up/technician/technician_appointments/ui/technician_appointments.dart';

class MockTechnicianAppointmentsBloc extends Mock
    implements TechnicianAppointmentsBloc {}

// Define a test
void main() {
  testWidgets('Technician Appointment page has app bar and person icon',
      (WidgetTester tester) async {
    // Create a TechnicianAppointmentsBloc instance
    final technicianAppointmentsBloc = TechnicianAppointmentsBloc();

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<TechnicianAppointmentsBloc>(
        create: (context) => technicianAppointmentsBloc,
        child: TechnicianAppointment(),
      ),
    ));

    final appBarFinder = find.byType(AppBar);
    // final personIconFinder = find.byIcon(Icons.person);
    final titleFinder = find.text('Technician Appointments');

    expect(appBarFinder, findsOneWidget);
    expect(titleFinder, findsOneWidget);
    // expect(personIconFinder, findsOneWidget);
  });

  testWidgets('displays no appointments in the absence of appointments',
      (WidgetTester tester) async {
    final technicianAppointmentsBloc = TechnicianAppointmentsBloc();

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<TechnicianAppointmentsBloc>(
        create: (context) => technicianAppointmentsBloc,
        child: TechnicianAppointment(),
      ),
    ));

    final textFinder = find.text("NO APPOINTMENTS");

    expect(textFinder, findsOneWidget);
  });

  testWidgets('displays bottom naviagtion bar', (WidgetTester tester) async {
    final technicianAppointmentsBloc = TechnicianAppointmentsBloc();

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<TechnicianAppointmentsBloc>(
        create: (context) => technicianAppointmentsBloc,
        child: TechnicianAppointment(),
      ),
    ));

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);
    expect(find.byIcon(Icons.build), findsOneWidget);
  });
}
