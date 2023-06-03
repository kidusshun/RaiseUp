import 'dart:convert';
import '../../globals.dart' as globals;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:raise_up/customers/customer_signin/bloc/customer_signin_bloc.dart';
import 'package:raise_up/customers/customer_signin/model/customer_confirmation_credential_model.dart';
import 'package:raise_up/customers/customer_signin/repository/customer_confirmation_credential_repository.dart';

import 'customer_signin_bloc_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final technicianCredential = globals.signinDto;
  group('mock client', () {
    test('returns success if signin successful', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('http://10.0.2.2:3000/customer/signin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      )).thenAnswer((_) async => http.Response('confirmed Successfully', 201));

      final response = await client.post(
        Uri.parse('http://10.0.2.2:3000/customer/signin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      );

      expect(response.statusCode, 201);
      expect(response.body, "confirmed Successfully");
    });

    test('emits unknown error', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('http://10.0.2.2:3000/customer/signin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      )).thenAnswer((_) async =>
          http.Response('Unknown Problem occured please try again later', 400));

      final response = await client.post(
        Uri.parse('http://10.0.2.2:3000/customer/signin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      );

      expect(response.statusCode, 400);
      expect(response.body, "Unknown Problem occured please try again later");
    });
  });

  group('TechnicianAccountInformationBloc', () {
    late CustomerSigninBloc bloc;
    late CustomerConfirmationCredentialRepository repository;

    setUp(() {
      repository = CustomerConfirmationCredentialRepositoryimpl();
      bloc = CustomerSigninBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is TechnicianAccountInformationInitial', () {
      expect(bloc.state, isA<CustomerSigninInitial>());
    });

    blocTest<CustomerSigninBloc, CustomerSigninState>(
      'emits TechnicianSelectionButtonClickedState when TechnicianSelectionButtonClickedEvent is added',
      build: () => bloc,
      act: (bloc) async {
        bloc.add(CustomerSigninEmailInputEvent(email: 'test@gmail.com'));
        bloc.add(CustomerSigninPasswordInputEvent(password: 'password'));
        bloc.add(CustomerSigninLoginButtonClickedEvent());
      },
      expect: () => [],
    );
  });
}
