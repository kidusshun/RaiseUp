import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/technician/technician_account_information/bloc/technician_account_information_bloc.dart';
import 'package:raise_up/technician/technician_account_information/model/technician_account_information_credential_model.dart';
import 'package:raise_up/technician/technician_account_information/repository/technician_account_information_credential_repository.dart';
import 'package:raise_up/technician/technician_account_information/ui/technician_account_information.dart';
import 'package:raise_up/widgets/gestureDetectorButton.dart';

void main() {
  group('TechnicianServiceRequest', () {
    Widget buildAccountInfomation() {
      return MaterialApp(
        home: Scaffold(
          body: TechnicianAccountInformation(),
        ),
      );
    }

    group('account information page', () {
      testWidgets('renders the account information page',
          (WidgetTester tester) async {
        // Build the widget
        await tester.pumpWidget(buildAccountInfomation());

        // Verify that the service requests are rendered
        expect(find.text('Account Information'), findsOneWidget);
        expect(find.text('Hello,'), findsOneWidget);
        expect(
            find.text('Tell us a bit more about yourself and your profession.'),
            findsOneWidget);
        expect(find.text('Expertise?'), findsOneWidget);
        expect(find.byType(GestureButton), findsNWidgets(9));
        expect(find.byKey(Key('phone')), findsOneWidget);
        expect(find.byKey(Key('garage')), findsOneWidget);
        expect(find.byKey(Key('location')), findsOneWidget);
        expect(find.byType(TextButton), findsOneWidget);
      });
      testWidgets('interact with the user', (WidgetTester tester) async {
        await tester.pumpWidget(buildAccountInfomation());
        await tester.enterText(find.byType(TextFormField).first, '1234567890');
        await tester.enterText(find.byType(TextFormField).at(1), 'My Garage');
        await tester.enterText(
            find.byType(TextFormField).last, 'Garage Location');
        await tester.tap(find.byType(TextButton));
      });
    });
  });
}
