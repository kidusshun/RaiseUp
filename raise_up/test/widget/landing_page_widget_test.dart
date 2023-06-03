import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/landing/ui/landing_page.dart';

void main() {
  testWidgets('test for major layout of landing page',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LandingPage(),
    ));

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(CurlyBackgroundPage), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(4));
  });

  testWidgets('renders background image and title',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LandingPage(),
    ));

    expect(
        find.byKey(
          Key("background image"),
        ),
        findsOneWidget);
  });

  testWidgets('LandingPage displays buttons', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LandingPage()));

    expect(find.text('Customer'), findsOneWidget);
    expect(find.text('Technician'), findsOneWidget);
  });
}
