part of 'technician_appointments_bloc.dart';

@immutable
abstract class TechnicianAppointmentsState {}

abstract class TechnicianAppointmentsActionState
    extends TechnicianAppointmentsState {}

class TechnicianAppointmentsInitial extends TechnicianAppointmentsState {}

class TechnicianAppointmentsInitState extends TechnicianAppointmentsState {
  List<TechnicianAppointments> customerCredential;
  TechnicianAppointmentsInitState({required this.customerCredential});
}

class TechnicianAppointmentsLoadingActionState
    extends TechnicianAppointmentsState {}

class TechnicianAppointmentsErrorActionState
    extends TechnicianAppointmentsActionState {
  String error;
  TechnicianAppointmentsErrorActionState({required this.error});
}

class TechnicianAppointmentsNavigateHomeState
    extends TechnicianAppointmentsActionState {}

class TechnicianAppointmentsNavigateState
    extends TechnicianAppointmentsActionState {}

class TechnicianAppointmentNavigateProfileState
    extends TechnicianAppointmentsActionState {}
