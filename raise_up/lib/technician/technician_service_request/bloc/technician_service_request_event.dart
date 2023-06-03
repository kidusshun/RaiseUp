part of 'technician_service_request_bloc.dart';

@immutable
abstract class TechnicianServiceRequestEvent {}

class TechnicianAppointmentInitialEvent extends TechnicianServiceRequestEvent {}


class TechnicianAppointmentSetEvent extends TechnicianServiceRequestEvent {
  TechnicianAppointment appointment;
  TechnicianAppointmentStatus status;
  TechnicianAppointmentSetEvent({required this.appointment,required this.status});
}

class TechnicianServiceRequestRefreshButtonClickedEvent
    extends TechnicianServiceRequestEvent {}



