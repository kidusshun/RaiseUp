import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/customers/customer_service_request/bloc/customer_service_request_bloc.dart';
import 'package:raise_up/customers/customer_service_request/model/customer_service_request_model.dart';
import 'package:raise_up/customers/customer_service_request/repository/customer_service_request_repository.dart';

import '../../globals.dart';
import 'customer_service_request_bloc_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('mock client', () {
    test('returns success if signup successful', () async {
      final client = MockClient();
      when(client.get(Uri.parse('http://10.0.2.2:3000/service-request/pending'),
          headers: {
            'Content-Type': 'application/json',
          })).thenAnswer((_) async => http.Response("request successful", 200));

      final response = await client.get(
          Uri.parse('http://10.0.2.2:3000/service-request/pending'),
          headers: {'Content-Type': 'application/json'});

      expect(response.statusCode, 200);
      expect(response.body, "request successful");
    });

    test('returns a use failed request', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/service-request/pending'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response('request failed', 400));

      final response = await client.get(
          Uri.parse('http://10.0.2.2:3000/service-request/pending'),
          headers: {'Content-Type': 'application/json'});

      expect(response.statusCode, 400);
      expect(response.body, "request failed");
    });
  });

  group('TechnicianSignupBloc', () {
    late CustomerServiceRequestBloc bloc;

    setUp(() {
      bloc = CustomerServiceRequestBloc();
    });

    tearDown(() {
      bloc.close();
    });
    blocTest<CustomerServiceRequestBloc, CustomerServiceRequestState>(
      'emits [TechnicianSignupLoadingActionState, TechnicianSignUpSucessActionState] when signup is successful',
      build: () {
        final Client = MockClient();
        when(Client.post(
          Uri.parse('http://10.0.2.2:3000/appointments/create'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(technicianCredential.toJson()),
        )).thenAnswer((_) async => http.Response('Created Successfully', 201));
        return CustomerServiceRequestBloc();
      },
      act: (bloc) => bloc.add(CustomerServiceRequestDeleteButtonClickedEvent(
          serviceRequestDelete: deleteService)),
      expect: () => [],
    );

    blocTest<CustomerServiceRequestBloc, CustomerServiceRequestState>(
      'emits [TechnicianSignupLoadingActionState, TechnicianSignUpSucessActionState] when signup is successful',
      build: () {
        final Client = MockClient();
        when(Client.get(
          Uri.parse('http://10.0.2.2:3000/service-request/pending'),
          headers: {'Content-Type': 'application/json'},
        )).thenAnswer((_) async => http.Response('Created Successfully', 201));
        return CustomerServiceRequestBloc();
      },
      act: (bloc) => bloc.add(CustomerServiceRequestTechnicianCardClickedEvent(
          updatedServiceRequest: updateService)),
      expect: () => [],
    );
  });
}
