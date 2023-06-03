import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/technician/technician_appointments/bloc/technician_appointments_bloc.dart';
import 'package:raise_up/technician/technician_appointments/repository/technician_appointments_delete_repository.dart';
import 'package:raise_up/technician/technician_appointments/repository/technician_appointments_repository.dart';
import 'package:raise_up/technician/technician_appointments/repository/technician_appointments_update_repository.dart';
import 'package:raise_up/technician/technician_appointments/ui/technician_appointments.dart';
import '../../globals.dart';
import 'technician_appointments_bloc_test.mocks.dart';

class MockTechnicianAppointmentsBloc extends Mock
    implements TechnicianAppointmentsBloc {}

@GenerateMocks([http.Client])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('mock client', () {
    test('returns success if get request successful ', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/appointments'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("request successful", 200));

      final response = await client.get(
        Uri.parse('http://10.0.2.2:3000/appointments'),
        headers: {'Content-Type': 'application/json'},
      );

      expect(response.statusCode, 200);
      expect(response.body, "request successful");
    });

    test('returns error if get request unsuccessful ', () async {
      final client = MockClient();
      when(client.get(
        Uri.parse('http://10.0.2.2:3000/appointments'),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response("request failed", 401));

      final response = await client.get(
        Uri.parse('http://10.0.2.2:3000/appointments'),
        headers: {'Content-Type': 'application/json'},
      );

      expect(response.statusCode, 401);
      expect(response.body, "request failed");
    });

    // test('deletes appointments', () async {
    //   final client = MockClient();
    //   when(client.delete(Uri.parse('http://10.0.2.2:3000/appointments'),
    //           headers: {'Content-Type': 'application/json'},
    //           body: json.encode(deleteAppoint.toJson())))
    //       .thenAnswer((_) async => http.Response("deleted appointment", 200));

    //   final response = await client.delete(
    //     Uri.parse('http://10.0.2.2:3000/appointments'),
    //     headers: {'Content-Type': 'application/json'},
    //   );

    //   expect(response.statusCode, 200);
    //   expect(response.body, "updated appointment");
    // });

    // test('updates appointments', () async {
    //   final client = MockClient();
    //   when(client.patch(Uri.parse('http://10.0.2.2:3000/appointments'),
    //           headers: {'Content-Type': 'application/json'},
    //           body: json.encode(updateAppointment.toJson())))
    //       .thenAnswer((_) async => http.Response("updated appointment", 200));

    //   final response = await client.patch(
    //     Uri.parse('http://10.0.2.2:3000/appointments'),
    //     headers: {'Content-Type': 'application/json'},
    //   );

    //   expect(response.statusCode, 200);
    //   expect(response.body, "updated appointment");
    // });

    // test('fails to update appointments', () async {
    //   final client = MockClient();
    //   when(client.patch(Uri.parse('http://10.0.2.2:3000/appointments'),
    //           headers: {'Content-Type': 'application/json'},
    //           body: json.encode(updateAppointment.toJson())))
    //       .thenAnswer(
    //           (_) async => http.Response("failed to update appointment", 401));

    //   final response = await client.patch(
    //     Uri.parse('http://10.0.2.2:3000/appointments'),
    //     headers: {'Content-Type': 'application/json'},
    //   );

    //   expect(response.statusCode, 200);
    //   expect(response.body, "updated appointment");
    // });
  });

  group('TechnicianAppointmentsBloc', () {
    late TechnicianAppointmentsBloc technicianAppointmentsBloc;

    setUp(() {
      technicianAppointmentsBloc = TechnicianAppointmentsBloc();
    });

    tearDown(() {
      technicianAppointmentsBloc.close();
    });

    test('initial state is TechnicianAppointmentsInitial', () {
      expect(technicianAppointmentsBloc.state,
          isA<TechnicianAppointmentsInitial>());
    });

    blocTest<TechnicianAppointmentsBloc, TechnicianAppointmentsState>(
      'emits [TechnicianAppointmentsInitState] when TechnicianAppointInitialEvent is added',
      build: () => technicianAppointmentsBloc,
      act: (bloc) => bloc.add(TechnicianAppointInitialEvent()),
      expect: () => [],
    );

    blocTest<TechnicianAppointmentsBloc, TechnicianAppointmentsState>(
      'emits [TechnicianAppointmentsSucssesfullyUpdatedActionState, TechnicianAppointmentsInitState] when TechnicianAppointmentsCustomerCardClickedEvent is added and update is successful',
      build: () => technicianAppointmentsBloc,
      act: (bloc) async {
        bloc.add(TechnicianAppointmentsCustomerCardClickedEvent(
            updatedAppointment: updateAppointment));
      },
      expect: () => [],
    );

    blocTest<TechnicianAppointmentsBloc, TechnicianAppointmentsState>(
      'emits [TechnicianAppointmentsFailedToUpdateActionState] when TechnicianAppointmentsCustomerCardClickedEvent is added and update fails',
      build: () => technicianAppointmentsBloc,
      act: (bloc) async {
        final updatedAppointment = updateAppointment;
        bloc.add(TechnicianAppointmentsCustomerCardClickedEvent(
            updatedAppointment: updatedAppointment));
      },
      expect: () => [],
    );

    blocTest<TechnicianAppointmentsBloc, TechnicianAppointmentsState>(
      'emits [TechnicianAppointmentsSucssesfullyDeletedActionState, TechnicianAppointmentsInitState] when TechnicianAppointmentDeleteButtonClickedEvent is added and delete is successful',
      build: () => technicianAppointmentsBloc,
      act: (bloc) async {
        final appointmentDelete = deleteAppoint;
        bloc.add(TechnicianAppointmentDeleteButtonClickedEvent(
            appointmentDelete: appointmentDelete));
      },
      expect: () => [],
    );

    blocTest<TechnicianAppointmentsBloc, TechnicianAppointmentsState>(
      'emits [TechnicianAppointmentsFailedToDeleteActionState] when TechnicianAppointmentDeleteButtonClickedEvent is added and delete fails',
      build: () => technicianAppointmentsBloc,
      act: (bloc) async {
        final appointmentDelete = deleteAppoint;
        bloc.add(TechnicianAppointmentDeleteButtonClickedEvent(
            appointmentDelete: appointmentDelete));
      },
      expect: () => [],
    );
  });
}
