import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/technician/technician_profile/bloc/technician_profile_bloc.dart';
import 'package:raise_up/technician/technician_profile/repository/technician_profile_repository.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';

import 'techinician_profile_bloc_test.mocks.dart';
import '../../globals.dart';

class MockTechnicianProfileBloc extends Mock implements TechnicianProfileBloc {}

class MockTechnicianProfileRepository extends Mock
    implements TechnicianProfileRepositoryImpl {}

@GenerateMocks([http.Client])
void main() {
  late TechnicianProfileBloc technicianProfileBloc;
  late TechnicianProfileRepository mockTechnicianProfileRepository;

  setUp(() {
    mockTechnicianProfileRepository = MockTechnicianProfileRepository();
    technicianProfileBloc = TechnicianProfileBloc();
  });

  tearDown(() {
    technicianProfileBloc.close();
  });
  group('mock test', () {
    test('returns success if get request successful ', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/appointments/past'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("request Successful", 200));

      final response = await client.get(
        Uri.parse('http://10.0.2.2:3000/appointments/past'),
        headers: {'Content-Type': 'application/json'},
      );

      expect(response.statusCode, 200);
      expect(response.body, "request Successful");
    });

    test('returns success if get technician request successful ', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/technician-profile/getTechnician'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("request Successfull", 200));

      final response = await client.get(
        Uri.parse('http://10.0.2.2:3000/technician-profile/getTechnician'),
        headers: {'Content-Type': 'application/json'},
      );

      expect(response.statusCode, 200);
      expect(response.body, "request Successfull");
    });

    test('returns None if get technician request fails', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/technician-profile/getTechnician'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("None", 401));

      final response = await client.get(
        Uri.parse('http://10.0.2.2:3000/technician-profile/getTechnician'),
        headers: {'Content-Type': 'application/json'},
      );

      expect(response.statusCode, 401);
      expect(response.body, "None");
    });
  });

  group('TechnicianProfileBloc', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    late TechnicianProfileBloc technicianProfileBloc;

    setUp(() {
      technicianProfileBloc = TechnicianProfileBloc();
    });

    tearDown(() {
      technicianProfileBloc.close();
    });

    test('initial state is TechnicianAppointmentsInitial', () {
      expect(technicianProfileBloc.state, isA<TechnicianProfileInitial>());
    });

    blocTest<TechnicianProfileBloc, TechnicianProfileState>(
      'emits [] when technicianHistoryInitialEvent is called without mockRepo',
      build: () => technicianProfileBloc,
      act: (bloc) => bloc.add(TechnicianHistoryInitialEvent()),
      expect: () => [],
    );

    blocTest<TechnicianProfileBloc, TechnicianProfileState>(
      'emits [TechnicianProfileNameLoadedState] when technicianHistoryInitialNameEvent is called',
      build: () => technicianProfileBloc,
      act: (bloc) => bloc.add(TechnicianHistoryInitialNameEvent()),
      expect: () => [],
    );
  });
}
