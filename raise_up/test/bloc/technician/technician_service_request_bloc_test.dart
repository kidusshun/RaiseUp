import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/technician/technician_service_request/bloc/technician_service_request_bloc.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:raise_up/technician/technician_service_request/repository/technician_appointment_repository.dart';

import '../../globals.dart';
import 'technician_service_request_bloc_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('mock client', () {
    test('returns success if signup successful', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('http://10.0.2.2:3000/appointments/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(appointment.toJson()),
      )).thenAnswer((_) async => http.Response("request successful", 201));

      final response = await client.post(
          Uri.parse('http://10.0.2.2:3000/appointments/create'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(appointment.toJson()));
      expect(response.statusCode, 201);
      expect(response.body, "request successful");
    });

    test('returns a use correct email message', () async {
      final client = MockClient();
      when(client.post(
        Uri.parse('http://10.0.2.2:3000/appointments/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(appointment.toJson()),
      )).thenAnswer((_) async => http.Response('request Failed', 400));

      final response = await client.post(
          Uri.parse('http://10.0.2.2:3000/appointments/create'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(appointment.toJson()));
      expect(response.statusCode, 400);
      expect(response.body, "request Failed");
    });
  });

  group('TechnicianSignupBloc', () {
    late TechnicianServiceRequestBloc bloc;

    setUp(() {
      bloc = TechnicianServiceRequestBloc();
    });

    tearDown(() {
      bloc.close();
    });
    blocTest<TechnicianServiceRequestBloc, TechnicianServiceRequestState>(
      'emits [TechnicianSignupLoadingActionState, TechnicianSignUpSucessActionState] when signup is successful',
      build: () {
        final Client = MockClient();
        when(Client.post(
          Uri.parse('http://10.0.2.2:3000/appointments/create'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(technicianCredential.toJson()),
        )).thenAnswer((_) async => http.Response('Created Successfully', 201));
        return TechnicianServiceRequestBloc();
      },
      act: (bloc) {
        final appointment = TechnicianAppointment(
          time: '2023-01-01T00:00:00.000Z',
          notes: 'Test User',
          customer_id: 5,
        );
        final client = MockClient();
        when(client.post(
          Uri.parse('http://10.0.2.2:3000/appointments/create'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(technicianCredential.toJson()),
        )).thenAnswer((_) async {
          // print(http.Response);
          return http.Response('Created Successfully', 201);
        });

        bloc.add(TechnicianAppointmentSetEvent(
            appointment: appointment, status: appointmentStatus));
      },
      expect: () => [],
    );
  });
}
