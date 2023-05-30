part of 'technician_service_request_bloc.dart';

@immutable
abstract class TechnicianServiceRequestEvent {}

class TechnicianServiceRequestCustomerAppointmentClickedEvent
    extends TechnicianServiceRequestEvent {}

class TechnicianServiceRequestCustomerProfileClickedEvent
    extends TechnicianServiceRequestEvent {}

class TechnicianAppointmentSetEvent extends TechnicianServiceRequestEvent{
  TechnicianAppointment appointment;
  TechnicianAppointmentSetEvent({required this.appointment});
}