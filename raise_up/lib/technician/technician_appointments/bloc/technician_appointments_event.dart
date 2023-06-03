part of 'technician_appointments_bloc.dart';

@immutable
abstract class TechnicianAppointmentsEvent {}

class TechnicianAppointmentsCustomerCardClickedEvent
    extends TechnicianAppointmentsEvent {
  String customerId;
  TechnicianAppointmentsCustomerCardClickedEvent({required this.customerId});
}

class TechnicianAppointInitialEvent extends TechnicianAppointmentsEvent {}

class TechnicianAppointmentHomeButtonClickedEvent
    extends TechnicianAppointmentsEvent {}

class TechnicianAppointmentToDoButtonClickedEvent
    extends TechnicianAppointmentsEvent {}

class TechnicianAppointmentProfileButtonClickedEvent
    extends TechnicianAppointmentsEvent {}
