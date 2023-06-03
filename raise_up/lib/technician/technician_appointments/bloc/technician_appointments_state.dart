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

class TechnicianAppointmentsErrorActionState
    extends TechnicianAppointmentsActionState {
  String error;
  TechnicianAppointmentsErrorActionState({required this.error});
}

class TechnicianAppointmentsSucssesfullyUpdatedActionState extends TechnicianAppointmentsActionState{
  String sucess;
  TechnicianAppointmentsSucssesfullyUpdatedActionState({required this.sucess});
}

class TechnicianAppointmentsFailedToUpdateActionState extends TechnicianAppointmentsActionState{
  String failure;
  TechnicianAppointmentsFailedToUpdateActionState({required this.failure});
}

class TechnicianAppointmentsSucssesfullyDeletedActionState extends TechnicianAppointmentsActionState{
  String sucess;
  TechnicianAppointmentsSucssesfullyDeletedActionState({required this.sucess});
}

class TechnicianAppointmentsFailedToDeleteActionState extends TechnicianAppointmentsActionState{
  String failure;
  TechnicianAppointmentsFailedToDeleteActionState({required this.failure});
}

class TechnicianAppointmentNoDataState extends TechnicianAppointmentsState{}


