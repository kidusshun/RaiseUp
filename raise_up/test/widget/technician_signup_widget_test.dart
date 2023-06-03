import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/technician/technician_signup/ui/technician_signup.dart';

void main() {
  testWidgets('TechnicianSignup has a title and a background image',
      (WidgetTester tester) async {
    await tester.pumpWidget(TechnicianSignup());

    final titleFinder = find.text('Wheels  ');
    final subtitleFinder = find.text('Keeping You On The Road');
    final technicianFinder = find.text('TECHNICIAN');
    final imageFinder = find.byType(Image);

    expect(titleFinder, findsOneWidget);
    expect(subtitleFinder, findsOneWidget);
    expect(technicianFinder, findsOneWidget);

    expect(imageFinder, findsWidgets);
  });

  testWidgets('singleChildScrollView scrolls the content',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TechnicianSignup(),
    ));

    final scrollableFinder = find.byKey(Key('main scroll'));
    await tester.drag(scrollableFinder, Offset(0, -100));
    await tester.pumpAndSettle();

    final SnackBarFinder = find.byType(SnackBar);
    expect(SnackBarFinder, findsNothing);
  });

  testWidgets(
      'TechnicianSignup page displays email, name, password and confim password input',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TechnicianSignup()));

    // Verify the presence of the email input field
    expect(find.byKey(Key('email')), findsOneWidget);

    // Verify the presence of the technician name input field
    expect(find.byKey(Key('name')), findsOneWidget);

    // Verify the presence of the password input field
    expect(find.byKey(Key('password')), findsOneWidget);

    // Verify the presence of the confirm password input field
    expect(find.byKey(Key('confirm password')), findsOneWidget);
  });

  testWidgets('TechnicianSignup page displays signup button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TechnicianSignup(),
    ));

    expect(find.byKey(Key('signup button')), findsOneWidget);
  });

  testWidgets('TechnicianSignup page displays text and login link',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TechnicianSignup(),
    ));

    final textFinder = find.text('Already have an account? ');
    final buttonFinder = find.byKey(Key('login button'));

    expect(textFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });
}
