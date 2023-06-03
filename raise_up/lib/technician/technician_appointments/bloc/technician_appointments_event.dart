part of 'technician_appointments_bloc.dart';

@immutable
abstract class TechnicianAppointmentsEvent {}

class TechnicianAppointInitialEvent extends TechnicianAppointmentsEvent {}

class TechnicianAppointmentsCustomerCardClickedEvent
    extends TechnicianAppointmentsEvent {
      TechnicianAppointmentsUpdate updatedAppointment;
  TechnicianAppointmentsCustomerCardClickedEvent({required this.updatedAppointment});
}

class TechnicianAppointmentDeleteButtonClickedEvent extends TechnicianAppointmentsEvent{
  TechnicianAppointmentDelete appointmentDelete;
  TechnicianAppointmentDeleteButtonClickedEvent({required this.appointmentDelete});
}







