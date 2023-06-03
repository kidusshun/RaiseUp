import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:raise_up/technician/technician_service_request/bloc/technician_service_request_bloc.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:raise_up/technician/technician_service_request/repository/technician_appointment_repository.dart';
import 'package:raise_up/technician/technician_service_request/ui/technician_service_request.dart';

class MockTechnicianServiceRequestBloc extends Mock
    implements TechnicianServiceRequestBloc {}

class MockTechnicianAppointmentRepository extends Mock
    implements TechnicianAppointmentRepository {
  @override
  Future<String> createAppointment(TechnicianAppointment appointment) {
    return Future.value("success"); // Replace with your desired implementation
  }
}

void main() {
  final mockAppointmentRepository = MockTechnicianAppointmentRepository();

  // Create a sample appointment
  // final appointment = TechnicianAppointment(
  //   customer_id: 1,
  //   notes: "Engine Defect",
  //   time: TimeOfDay.now(),
  // );

  final bloc = TechnicianServiceRequestBloc();
  group('TechnicianServiceRequest', () {
    late TechnicianServiceRequestBloc technicianServiceRequestBloc;

    setUp(() {
      technicianServiceRequestBloc = MockTechnicianServiceRequestBloc();
    });

    testWidgets('renders the service requests', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: TechnicianServiceStRequest(),
        ),
      );

      // Verify that the service requests are rendered
      expect(find.byKey(Key('title')), findsOneWidget);
    });
  });
}
