import 'dart:convert';
import '../globals.dart' as globals;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:raise_up/technician/technician_signin/bloc/technician_signin_bloc.dart';
import 'package:raise_up/technician/technician_signin/model/technician_confirmation_credential_model.dart';
import 'package:raise_up/technician/technician_signin/repository/technician_confirmation_credential_repository.dart';

import 'technician_signin_bloc_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final technicianCredential = globals.signinDto;
  group('mock client', () {
    test('returns success if signin successful', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('http://10.0.2.2:3000/technician/signin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      )).thenAnswer((_) async => http.Response('confirmed Successfully', 201));
    });

    test('emits unknown error', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('http://10.0.2.2:3000/technician/signin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(technicianCredential.toJson()),
      )).thenAnswer((_) async =>
          http.Response('Unknown Problem occured please try again later', 400));
    });
  });
  group('TechnicianAccountInformationBloc', () {
    late TechnicianSigninBloc bloc;
    late TechnicianConfirmationCredentialRepository repository;

    setUp(() {
      repository = TechnicianConfirmationCredentialRepositoryimpl();
      bloc = TechnicianSigninBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is TechnicianAccountInformationInitial', () {
      expect(bloc.state, isA<TechnicianSigninInitial>());
    });

    blocTest<TechnicianSigninBloc, TechnicianSigninState>(
      'emits TechnicianSelectionButtonClickedState when TechnicianSelectionButtonClickedEvent is added',
      build: () => bloc,
      act: (bloc) async {
        bloc.add(TechnicianSigninEmailInputEvent(email: 'test@gmail.com'));
        bloc.add(TechnicianSigninPasswordInputEvent(password: 'password'));
        bloc.add(TechnicianSigninLoginButtonClickedEvent());
      },
      expect: () => [isA<TechnicianSigninLoadingActionState>()],
    );
  });
}
