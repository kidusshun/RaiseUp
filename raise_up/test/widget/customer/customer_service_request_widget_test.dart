import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/customers/customer_service_request/bloc/customer_service_request_bloc.dart';
import 'package:raise_up/customers/customer_service_request/model/customer_service_request_model.dart';
import 'package:raise_up/customers/customer_service_request/repository/customer_service_request_repository.dart';
import 'package:raise_up/customers/customer_service_request/ui/customer_service_request.dart';

class MockCustomerServiceRequestBloc extends Mock
    implements CustomerServiceRequestBloc {}

void main() {
  final bloc = CustomerServiceRequestBloc();
  group('TechnicianServiceRequest', () {
    late CustomerServiceRequestBloc customerServiceRequestBloc;

    setUp(() {
      customerServiceRequestBloc = MockCustomerServiceRequestBloc();
    });

    testWidgets('renders the service requests', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: CustomerServiceStRequest(),
        ),
      );

      // Verify that the service requests are rendered
      expect(find.byKey(Key('title')), findsOneWidget);
    });
  });
}
