import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/customers/customer_technician_list/bloc/customer_technician_list_bloc.dart';
import 'package:raise_up/customers/customer_technician_list/repository/customer_date_selection_repository.dart';
import 'package:raise_up/customers/customer_technician_list/repository/technician_credential_repository.dart';
import 'package:raise_up/customers/customer_technician_list/model/technician_credential_model.dart';
import 'package:raise_up/customers/customer_technician_list/model/customer_service_request_model.dart';

import 'customer_technician_list_bloc_test.mocks.dart';
import '../globals.dart';

TechnicianCredential credential = TechnicianCredential(
    expertise: ["engine"],
    garage: "garage",
    id: 1,
    location: "addis ababa",
    name: "name");
@GenerateMocks([http.Client])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('mock client', () {
    test('returns success if  successfully appointed', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/customer-profile/getAllTechnician'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("Successfully Appointed!", 200));
    });

    test('returns a failed to appoint customer', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('Failed to Appoint Customer'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(serviceRequest.toJson()),
      )).thenAnswer(
          (_) async => http.Response('Failed to appoint customer', 400));
    });
  });

  group('CustomerTechnicianListBloc', () {
    late CustomerTechnicianListBloc bloc;
    late CustomerDateSeclectionRepositoryImpl customerDateSeclectionRepository;

    setUp(() {
      customerDateSeclectionRepository = CustomerDateSeclectionRepositoryImpl();
      bloc = CustomerTechnicianListBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is CustomerTechnicianListInitial', () {
      expect(bloc.state, isA<CustomerTechnicianListInitial>());
    });

    blocTest<CustomerTechnicianListBloc, CustomerTechnicianListState>(
      'emits nothing in test for button clicked',
      build: () => bloc,
      act: (bloc) => bloc.add(CustomerTechnicianListBookButtonClickedEvent(
          iso: '', notes: 'notest', technicianId: 1)),
      expect: () => [],
    );
  });
}
