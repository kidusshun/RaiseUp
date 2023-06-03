import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:raise_up/customers/customer_signin/bloc/customer_signin_bloc.dart';
import 'package:raise_up/customers/customer_signin/model/customer_confirmation_credential_model.dart';
import 'package:raise_up/customers/customer_signin/ui/customer_signin.dart';

void main() {
  group('TechnicianSignin', () {
    Widget buildTechnicianSigninPage() {
      return MaterialApp(
        home: Scaffold(
          body: CustomerSignin(),
        ),
      );
    }

    testWidgets('renders the TechnicianSignin page',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTechnicianSigninPage());

      expect(find.text("Wheels  "), findsOneWidget);
      expect(find.text('Keeping You On The Road'), findsOneWidget);
      expect(find.text('Customer'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(TextButton), findsNWidgets(2));
    });
  });

  testWidgets('singleChildScrollView scrolls the content',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CustomerSignin(),
    ));

    final scrollableFinder = find.byKey(Key('main scroll'));
    await tester.drag(scrollableFinder, Offset(0, -50));
    await tester.pumpAndSettle();

    final SnackBarFinder = find.byType(SnackBar);
    expect(SnackBarFinder, findsNothing);
  });

  testWidgets('TechnicianSignin page displays email, password input',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomerSignin()));

    expect(find.byKey(Key('email')), findsOneWidget);

    expect(find.byKey(Key('password')), findsOneWidget);
  });

  testWidgets('TextFormField accepts input', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomerSignin()));

    await tester.enterText(find.byKey(Key('email')), 'Hello World');

    expect(find.text('Hello World'), findsOneWidget);
  });

  testWidgets('TechnicianSignin page displays signup button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CustomerSignin(),
    ));

    expect(find.byKey(Key('signin button')), findsOneWidget);
  });

  testWidgets('TechnicianSignin page displays text and login link',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CustomerSignin(),
    ));

    final textFinder = find.text("Don't have an account? ");
    final buttonFinder = find.byKey(Key('signup button'));

    expect(textFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });
}
