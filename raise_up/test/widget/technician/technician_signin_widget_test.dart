import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:raise_up/technician/technician_signin/bloc/technician_signin_bloc.dart';
import 'package:raise_up/technician/technician_signin/model/technician_confirmation_credential_model.dart';
import 'package:raise_up/technician/technician_signin/ui/technician_signin.dart';

void main() {
  group('TechnicianSignin', () {
    Widget buildTechnicianSigninPage() {
      return MaterialApp(
        home: Scaffold(
          body: TechnicianSignin(),
        ),
      );
    }

    testWidgets('renders the TechnicianSignin page',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTechnicianSigninPage());

      expect(find.text("Wheels  "), findsOneWidget);
      expect(find.text('Keeping You On The Road'), findsOneWidget);
      expect(find.text('TECHNICIAN'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(TextButton), findsNWidgets(2));
    });
  });

  testWidgets('singleChildScrollView scrolls the content',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TechnicianSignin(),
    ));

    final scrollableFinder = find.byKey(Key('main scroll'));
    await tester.drag(scrollableFinder, Offset(0, -50));
    await tester.pumpAndSettle();

    final SnackBarFinder = find.byType(SnackBar);
    expect(SnackBarFinder, findsNothing);
  });

  testWidgets('TechnicianSignin page displays email, password input',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TechnicianSignin()));

    expect(find.byKey(Key('email')), findsOneWidget);

    expect(find.byKey(Key('password')), findsOneWidget);
  });

  testWidgets('TextFormField accepts input', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TechnicianSignin()));

    await tester.enterText(find.byKey(Key('email')), 'Hello World');

    expect(find.text('Hello World'), findsOneWidget);
  });

  testWidgets('TechnicianSignin page displays signup button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TechnicianSignin(),
    ));

    expect(find.byKey(Key('signin button')), findsOneWidget);
  });

  testWidgets('TechnicianSignin page displays text and login link',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TechnicianSignin(),
    ));

    final textFinder = find.text('Already have an account? ');
    final buttonFinder = find.byKey(Key('signup button'));

    expect(textFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });
}
