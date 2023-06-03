import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:raise_up/technician/technician_signup/ui/technician_signup.dart';

void main() {
  group('TechnicianSignup Widget Test', () {
    testWidgets('TechnicianSignup renders a title and a background image',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: TechnicianSignup(),
        ),
      );

      expect(find.text("Wheels  "), findsWidgets);
      expect(find.text("TECHNICIAN"), findsOneWidget);
      expect(find.text("Keeping You On The Road"), findsOneWidget);
      expect(find.byKey(Key("background image")), findsOneWidget);
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

      expect(find.byKey(Key('email')), findsOneWidget);

      expect(find.byKey(Key('name')), findsOneWidget);

      expect(find.byKey(Key('password')), findsOneWidget);

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
  });
}
