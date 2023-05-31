part of 'technician_appointments_bloc.dart';

@immutable
abstract class TechnicianAppointmentsEvent {}

class TechnicianAppointmentsCustomerCardClickedEvent extends TechnicianAppointmentsEvent{
  String customerId;
  TechnicianAppointmentsCustomerCardClickedEvent({required this.customerId});
}
