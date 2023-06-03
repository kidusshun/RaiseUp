import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:raise_up/customers/customer_profile/bloc/customer_profile_bloc.dart';
import 'package:raise_up/customers/customer_profile/repository/customer_profile_repository.dart';
import 'package:raise_up/customers/customer_profile/ui/customer_profile.dart';

import '../../globals.dart';
import 'customer_profile_bloc_test.mocks.dart';

class MockCustomerProfileBloc extends Mock implements CustomerProfileBloc {}

class MockCustomerProfileRepository extends Mock
    implements CustomerProfileRepositoryImpl {}

@GenerateMocks([http.Client])
void main() {
  late CustomerProfileBloc customerProfileBloc;
  late CustomerProfileRepository mockCustomerProfileRepository;

  setUp(() {
    mockCustomerProfileRepository = MockCustomerProfileRepository();
    customerProfileBloc = CustomerProfileBloc();
  });

  tearDown(() {
    customerProfileBloc.close();
  });

  group('mock test', () {
    test('returns success if get request successful ', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/service-request/past'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("request Successful", 200));

      final response = await client.get(
        Uri.parse('http://10.0.2.2:3000/service-request/past'),
        headers: {'Content-Type': 'application/json'},
      );

      expect(response.statusCode, 200);
      expect(response.body, "request Successful");
    });

    test('returns success if get technician request successful ', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/customer-profile'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("request Successfull", 200));

      final response = await client.get(
        Uri.parse('http://10.0.2.2:3000/customer-profile'),
        headers: {'Content-Type': 'application/json'},
      );

      expect(response.statusCode, 200);
      expect(response.body, "request Successfull");
    });

    test('returns success if get request successful', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/service-request/past'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("request failed", 401));

      final response = await client.get(
        Uri.parse('http://10.0.2.2:3000/service-request/past'),
        headers: {'Content-Type': 'application/json'},
      );

      expect(response.statusCode, 401);
      expect(response.body, "request failed");
    });

    test('returns success if get technician request successful ', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/customer-profile'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("request failed", 401));

      final response = await client.get(
        Uri.parse('http://10.0.2.2:3000/customer-profile'),
        headers: {'Content-Type': 'application/json'},
      );

      expect(response.statusCode, 401);
      expect(response.body, "request failed");
    });
  });

  group('TechnicianProfileBloc', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    late CustomerProfileBloc customerProfileBloc;

    setUp(() {
      customerProfileBloc = CustomerProfileBloc();
    });

    tearDown(() {
      customerProfileBloc.close();
    });

    blocTest<CustomerProfileBloc, CustomerProfileState>(
      'emits [] when technicianHistoryInitialEvent is called without mockRepo',
      build: () => customerProfileBloc,
      act: (bloc) => bloc.add(CustomerHistoryInitialEvent()),
      expect: () => [],
    );

    blocTest<CustomerProfileBloc, CustomerProfileState>(
      'emits [TechnicianProfileNameLoadedState] when technicianHistoryInitialNameEvent is called',
      build: () => customerProfileBloc,
      act: (bloc) => bloc.add(CustomerHistoryInitialNameEvent()),
      expect: () => [],
    );
  });
}
