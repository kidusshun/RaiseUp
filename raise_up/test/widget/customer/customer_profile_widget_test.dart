import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:raise_up/customers/customer_profile/bloc/customer_profile_bloc.dart';
import 'package:raise_up/customers/customer_profile/ui/customer_profile.dart';

void main() {
  testWidgets('renders a person Icon', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
      create: (context) => CustomerProfileBloc(),
      child: CustomerProfile(),
    )));

    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.text("History:"), findsOneWidget);
    expect(find.text("No History"), findsOneWidget);
  });

  testWidgets('renders the bottom navigation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
      create: (context) => CustomerProfileBloc(),
      child: CustomerProfile(),
    )));

    expect(find.byType(BottomAppBar), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.build), findsOneWidget);
  });
}
