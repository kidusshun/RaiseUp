import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:raise_up/technician/technician_profile/bloc/technician_profile_bloc.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';

void main() {
  testWidgets('renders a person Icon', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
      create: (context) => TechnicianProfileBloc(),
      child: TechnicianProfile(),
    )));

    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.text("History:"), findsOneWidget);
    expect(find.text("No History"), findsOneWidget);
  });

  testWidgets('renders the bottom navigation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
      create: (context) => TechnicianProfileBloc(),
      child: TechnicianProfile(),
    )));
    expect(find.byType(BottomAppBar), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.build), findsOneWidget);
  });
}
