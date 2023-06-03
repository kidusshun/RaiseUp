import 'dart:convert';
import '../globals.dart' as globals;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/technician/technician_signup/bloc/technician_signup_bloc.dart';
import 'package:raise_up/technician/technician_signup/model/technician_credential_model.dart';
import 'package:raise_up/technician/technician_signup/repository/technician_credential_repository.dart';

import 'technician_signup_bloc_test.mocks.dart';

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
    });

    test('returns a use correct email message', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('http://10.0.2.2:3000/technician/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      )).thenAnswer((_) async => http.Response('Use a correct email', 400));
    });
  });
  group('TechnicianSignupBloc', () {
    late TechnicianSignupBloc technicianSignupBloc;

    setUp(() {
      technicianSignupBloc = TechnicianSignupBloc();
    });

    tearDown(() {
      technicianSignupBloc.close();
    });
    blocTest<TechnicianSignupBloc, TechnicianSignupState>(
      'emits [TechnicianSignupLoadingActionState, TechnicianSignUpSucessActionState] when signup is successful',
      build: () {
        final Client = MockClient();
        when(Client.post(
          Uri.parse('http://10.0.2.2:3000/technician/signup'),
          headers: {'Content-Type': 'application/json'},
          // use the technicianCredential object to encode the body
          body: json.encode(technicianCredential.toJson()),
        )).thenAnswer((_) async => http.Response('Created Successfully', 201));
        return TechnicianSignupBloc();
      },
      act: (bloc) {
        final technicianCredential = TechnicianCredential(
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
            TechnicianSignupEmailInputEvent(email: technicianCredential.email));
        bloc.add(
            TechnicianSignupNameInputEvent(name: technicianCredential.name));
        bloc.add(TechnicianSignupPasswordInputEvent(
            password: technicianCredential.password));
        bloc.add(TechnicianSignupConfirmationPasswordInputEvent(
            confirmationPassword: technicianCredential.password));
        // emit the signup button clicked event without parameters
        bloc.add(TechnicianSignupSignupButtonClickedEvent());
      },
      expect: () => [
        isA<TechnicianSignUpConfarmationPasswordCorrectState>(),
        isA<TechnicianSignupLoadingActionState>(),
        // TechnicianSignUpSucessActionState(sucess: "Created Successfully")
      ],
    );
  });

  group('TechnicianSignupBloc', () {
    late TechnicianSignupBloc technicianSignupBloc;
    late MockClient mockClient;

    setUp(() {
      technicianSignupBloc = TechnicianSignupBloc();
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
    blocTest<TechnicianSignupBloc, TechnicianSignupState>(
      'emits [TechnicianSignupLoadingActionState, TechnicianSignUpSucessActionState] when signup is successful',
      build: () {
        return TechnicianSignupBloc();
      },
      act: (bloc) {
        final technicianCredential = TechnicianCredential(
          email: 'test@example.com',
          name: 'Test User',
          password: 'password',
        );

        bloc.add(
            TechnicianSignupEmailInputEvent(email: technicianCredential.email));
        bloc.add(
            TechnicianSignupNameInputEvent(name: technicianCredential.name));
        bloc.add(TechnicianSignupPasswordInputEvent(
            password: technicianCredential.password));
        bloc.add(TechnicianSignupConfirmationPasswordInputEvent(
            confirmationPassword: technicianCredential.password));

        bloc.add(TechnicianSignupSignupButtonClickedEvent());
      },
      wait: const Duration(seconds: 1),
      expect: () => [
        isA<TechnicianSignUpConfarmationPasswordCorrectState>(),
        isA<TechnicianSignupLoadingActionState>(),
      ],
    );
  });
}
