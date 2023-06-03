import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:raise_up/technician/technician_account_information/bloc/technician_account_information_bloc.dart';
import 'package:raise_up/technician/technician_account_information/repository/technician_account_information_credential_repository.dart';

import '../../globals.dart';
import 'technician_account_information_bloc_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('mock client', () {
    test('returns success if signup successful', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('http://10.0.2.2:3000/technician-profile'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(account.toJson()),
      )).thenAnswer((_) async => http.Response("Successfully created!", 201));

      final response = await client.post(
        Uri.parse('http://10.0.2.2:3000/technician-profile'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(account.toJson()),
      );

      expect(response.statusCode, 201);
      expect(response.body, "Successfully created!");
    });

    test('returns a use correct email message', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('http://10.0.2.2:3000/appointments/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(account.toJson()),
      )).thenAnswer(
          (_) async => http.Response('Failed to Appoint Customer', 400));

      final response = await client.post(
        Uri.parse('http://10.0.2.2:3000/appointments/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(account.toJson()),
      );

      expect(response.statusCode, 400);
      expect(response.body, "Failed to Appoint Customer");
    });
  });
  group('TechnicianAccountInformationBloc', () {
    late TechnicianAccountInformationBloc bloc;
    late TechnicianAccountInformationCredentialRepository repository;

    setUp(() {
      repository = TechnicianAccountInformationCredentialRepositoryImpl();
      bloc = TechnicianAccountInformationBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is TechnicianAccountInformationInitial', () {
      expect(bloc.state, isA<TechnicianAccountInformationInitial>());
    });

    blocTest<TechnicianAccountInformationBloc,
        TechnicianAccountInformationState>(
      'emits TechnicianSelectionButtonClickedState when TechnicianSelectionButtonClickedEvent is added',
      build: () => bloc,
      act: (bloc) => bloc
          .add(TechnicianSelectionButtonClickedEvent(buttonName: 'Button1')),
      expect: () => [isA<TechnicianSelectionButtonClickedState>()],
    );

    blocTest<TechnicianAccountInformationBloc,
        TechnicianAccountInformationState>(
      'emits TechnicianSelectionButtonUnclickedState when TechnicianSelectionButtonUnclickedEvent is added',
      build: () => bloc,
      act: (bloc) => bloc
          .add(TechnicianSelectionButtonUnclickedEvent(buttonName: 'Button1')),
      expect: () => [isA<TechnicianSelectionButtonUnclickedState>()],
    );

    blocTest(
      'emits TechnicianSelectionButtonClickedState when fields are added',
      build: () => bloc,
      act: (bloc) async {
        bloc.add(TechnicianGarageLocationInputEvent(
            garageLocation: "garageLocation"));
        bloc.add(TechnicianGarageNameInputEvent(garageName: "name"));
        bloc.add(TechnicianPhoneNumberInputEvent(phoneNumber: "5556849"));
      },
      expect: () => [
        isA<TechnicianSelectionButtonClickedState>(),
        isA<TechnicianSelectionButtonClickedState>(),
        isA<TechnicianSelectionButtonClickedState>(),
      ],
    );

    blocTest<TechnicianAccountInformationBloc,
        TechnicianAccountInformationState>(
      'emits TechnicianInputFailureActionState when TechnicianAccountInformationSubmitButtonEvent is added with invalid credentials',
      build: () => bloc,
      act: (bloc) => bloc.add(TechnicianAccountInformationSubmitButtonEvent()),
      expect: () => [isA<TechnicianInputFailureActionState>()],
    );
  });
}
