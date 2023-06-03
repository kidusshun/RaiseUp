import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:raise_up/customers/customer_technician_list/bloc/customer_technician_list_bloc.dart';
import 'package:raise_up/customers/customer_technician_list/ui/customer_technician_list.dart';

void main() {
  group('TechnicianServiceRequest', () {
    Widget buildAccountInfomation() {
      return MaterialApp(
        home: Scaffold(
          body: CustomerTechnicianStList(),
        ),
      );
    }

    group('CustomerTechnicianList initial widget testWidget Test', () {
      testWidgets('Should display technician list when initialized',
          (WidgetTester tester) async {
        final mockBloc = CustomerTechnicianListBloc();
        await tester.pumpWidget(buildAccountInfomation());

        expect(find.text('Customer Technician List'), findsOneWidget);

        expect(find.text('NO Technicians'), findsOneWidget);
      });
    });
  });
}
