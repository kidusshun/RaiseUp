import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:raise_up/customers/customer_appointments/bloc/customer_appointments_bloc.dart';
import 'package:raise_up/customers/customer_appointments/model/customer_appointments_model.dart';
import 'package:raise_up/customers/customer_appointments/repository/customer_appointments_repository.dart';
import 'package:raise_up/customers/customer_appointments/ui/customer_appointments.dart';
import '../../globals.dart';
import 'customer_appointments_bloc_test.mocks.dart';

class MockCustomerAppointmentsBloc extends Mock
    implements CustomerAppointmentsBloc {}

@GenerateMocks([http.Client])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('mock client', () {
    test('returns success if get request successful ', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/service-request/appointments'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("Successfully Appointed!", 200));

      final response = await client.get(
        Uri.parse('http://10.0.2.2:3000/service-request/appointments'),
        headers: {'Content-Type': 'application/json'},
      );

      expect(response.statusCode, 200);
      expect(response.body, "Successfully Appointed!");
    });

    test('returns success if get request fails ', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/service-request/appointments'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("reqeust failed", 401));

      final response = await client.get(
        Uri.parse('http://10.0.2.2:3000/service-request/appointments'),
        headers: {'Content-Type': 'application/json'},
      );

      expect(response.statusCode, 401);
      expect(response.body, "reqeust failed");
    });
  });

  group('CustomerAppointmentsBloc', () {
    late CustomerAppointmentsBloc customerAppointmentsBloc;

    setUp(() {
      customerAppointmentsBloc = CustomerAppointmentsBloc();
    });

    tearDown(() {
      customerAppointmentsBloc.close();
    });

    blocTest<CustomerAppointmentsBloc, CustomerAppointmentsState>(
      'emits [CustomerAppointmentsLoadingActionState, CustomerAppointmentsInitState] when CustomerAppointInitialEvent is added',
      build: () => customerAppointmentsBloc,
      act: (bloc) => bloc.add(CustomerAppointInitialEvent()),
      expect: () => [
        isA<CustomerAppointmentsLoadingActionState>(),
      ],
    );

    blocTest<CustomerAppointmentsBloc, CustomerAppointmentsState>(
      'emits [CustomerAppointmentsNoDataState] when response length is 0',
      build: () => customerAppointmentsBloc,
      act: (bloc) => bloc.add(CustomerAppointInitialEvent()),
      expect: () => [
        isA<CustomerAppointmentsLoadingActionState>(),
      ],
    );

    blocTest<CustomerAppointmentsBloc, CustomerAppointmentsState>(
      'emits [CustomerAppointmentsErrorActionState] when response contains an error',
      build: () => customerAppointmentsBloc,
      act: (bloc) => bloc.add(CustomerAppointInitialEvent()),
      expect: () => [
        isA<CustomerAppointmentsLoadingActionState>(),
      ],
    );
  });
}
