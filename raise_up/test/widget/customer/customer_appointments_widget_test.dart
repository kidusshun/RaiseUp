import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/customers/customer_appointments/bloc/customer_appointments_bloc.dart';
import 'package:raise_up/customers/customer_appointments/model/customer_appointments_model.dart';
import 'package:raise_up/customers/customer_appointments/ui/customer_appointments.dart';

class MockCustomerAppointmentsBloc extends Mock
    implements CustomerAppointmentsBloc {}

void main() {
  testWidgets('Technician Appointment page has app bar',
      (WidgetTester tester) async {
    // Create a TechnicianAppointmentsBloc instance
    final technicianAppointmentsBloc = CustomerAppointmentsBloc();

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<CustomerAppointmentsBloc>(
        create: (context) => technicianAppointmentsBloc,
        child: CustomerStAppointment(),
      ),
    ));

    final appBarFinder = find.byType(AppBar);
    final titleFinder = find.text('Technician appointments');

    expect(appBarFinder, findsOneWidget);
    expect(titleFinder, findsOneWidget);

    expect(find.text('Profile'), findsNothing);
    expect(find.text('Logout'), findsNothing);
  });

  testWidgets(
      'appbar reveals profile and logout when Icon.more_vert is clicked',
      (WidgetTester tester) async {
    final technicianAppointmentsBloc = CustomerAppointmentsBloc();

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<CustomerAppointmentsBloc>(
        create: (context) => technicianAppointmentsBloc,
        child: CustomerStAppointment(),
      ),
    ));
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('renders No Appointment when there is no data',
      (WidgetTester tester) async {
    final technicianAppointmentsBloc = CustomerAppointmentsBloc();

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<CustomerAppointmentsBloc>(
        create: (context) => technicianAppointmentsBloc,
        child: CustomerStAppointment(),
      ),
    ));

    expect(find.text('No Appointment'), findsOneWidget);
  });
}
