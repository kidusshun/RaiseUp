import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:raise_up/customers/customer_signup/bloc/customer_signup_bloc.dart';
import 'package:raise_up/customers/customer_signup/model/customer_credential_model.dart';
import 'package:raise_up/customers/customer_signup/Repository/customer_credential_repository.dart';

import '../../globals.dart' as globals;
import 'customer_signup_bloc_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final technicianCredential = globals.technicianCredential;

  group('mock client', () {
    test('returns success if signup successful', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('http://10.0.2.2:3000/technician/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      )).thenAnswer((_) async => http.Response('Created Successfully', 201));
      final response = await client.post(
        Uri.parse('http://10.0.2.2:3000/technician/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      );

      expect(response.statusCode, 201);
      expect(response.body, "Created Successfully");
    });

    test('returns a use correct email message', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('http://10.0.2.2:3000/technician/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      )).thenAnswer((_) async => http.Response('Use a correct email', 403));

      final response = await client.post(
        Uri.parse('http://10.0.2.2:3000/technician/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      );

      expect(response.statusCode, 403);
      expect(response.body, "Use a correct email");
    });
  });
  group('TechnicianSignupBloc', () {
    late CustomerSignupBloc technicianSignupBloc;

    setUp(() {
      technicianSignupBloc = CustomerSignupBloc();
    });

    tearDown(() {
      technicianSignupBloc.close();
    });
    blocTest<CustomerSignupBloc, CustomerSignupState>(
      'emits [TechnicianSignupLoadingActionState, TechnicianSignUpSucessActionState] when signup is successful',
      build: () {
        final Client = MockClient();
        when(Client.post(
          Uri.parse('http://10.0.2.2:3000/technician/signup'),
          headers: {'Content-Type': 'application/json'},
          // use the technicianCredential object to encode the body
          body: json.encode(technicianCredential.toJson()),
        )).thenAnswer((_) async => http.Response('Created Successfully', 201));
        return CustomerSignupBloc();
      },
      act: (bloc) {
        final technicianCredential = CustomerCredential(
          email: 'test@example.com',
          name: 'Test User',
          password: 'password',
        );
        final client = MockClient();
        when(client.post(
          Uri.parse('http://10.0.2.2:3000/technician/signup'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(technicianCredential.toJson()),
        )).thenAnswer((_) async {
          print(http.Response);
          return http.Response('Created Successfully', 201);
        });

        bloc.add(
            CustomerSignupEmailInputEvent(email: technicianCredential.email));
        bloc.add(CustomerSignupNameInputEvent(name: technicianCredential.name));
        bloc.add(CustomerSignupPasswordInputEvent(
            password: technicianCredential.password));
        bloc.add(CustomerSignupConfirmationPasswordInputEvent(
            confirmationPassword: technicianCredential.password));
        // emit the signup button clicked event without parameters
        bloc.add(CustomerSignupSignupButtonClickedEvent());
      },
      expect: () => [
        isA<CustomerSignUpConfarmationPasswordCorrectState>(),
        isA<CustomerSignupLoadingActionState>(),
      ],
    );
  });

  group('TechnicianSignupBloc', () {
    late CustomerSignupBloc technicianSignupBloc;
    late MockClient mockClient;

    setUp(() {
      technicianSignupBloc = CustomerSignupBloc();
      mockClient = MockClient();
      // stub the post method with the mock client
      when(mockClient.post(
        Uri.parse('http://10.0.2.2:3000/technician/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      )).thenAnswer((_) async => http.Response('Created Successfully', 201));
    });

    tearDown(() {
      technicianSignupBloc.close();
    });

    test('returns success if signup successful', () async {
      final response = await mockClient.post(
        Uri.parse('http://10.0.2.2:3000/technician/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      );
      expect(response.statusCode, 201);
    });
    blocTest<CustomerSignupBloc, CustomerSignupState>(
      'emits [TechnicianSignupLoadingActionState, TechnicianSignUpSucessActionState] when signup is successful',
      build: () {
        return CustomerSignupBloc();
      },
      act: (bloc) {
        final technicianCredential = CustomerCredential(
          email: 'test@example.com',
          name: 'Test User',
          password: 'password',
        );

        bloc.add(
            CustomerSignupEmailInputEvent(email: technicianCredential.email));
        bloc.add(CustomerSignupNameInputEvent(name: technicianCredential.name));
        bloc.add(CustomerSignupPasswordInputEvent(
            password: technicianCredential.password));
        bloc.add(CustomerSignupConfirmationPasswordInputEvent(
            confirmationPassword: technicianCredential.password));

        bloc.add(CustomerSignupSignupButtonClickedEvent());
      },
      wait: const Duration(seconds: 1),
      expect: () => [
        isA<CustomerSignUpConfarmationPasswordCorrectState>(),
        isA<CustomerSignupLoadingActionState>(),
      ],
    );
  });
}
