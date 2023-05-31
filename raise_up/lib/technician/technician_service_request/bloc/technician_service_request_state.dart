part of 'technician_service_request_bloc.dart';

@immutable
abstract class TechnicianServiceRequestState {}

abstract class TechnicianServiceRequestActionState
    extends TechnicianServiceRequestState {}

class TechnicianServiceRequestInitial extends TechnicianServiceRequestState {}

class TechnicianAppointmentLoadingState extends TechnicianServiceRequestActionState{}

class TechnicianAppointmentSuccessState extends TechnicianServiceRequestActionState{
  String sucess;
  TechnicianAppointmentSuccessState({required this.sucess});
}

class TechnicianAppointmentUnSuccessfulState extends TechnicianServiceRequestActionState{
  String failure;
  TechnicianAppointmentUnSuccessfulState({required this.failure});
}

class TechnicianAppointmentNavigateToHomeActionState extends TechnicianServiceRequestActionState{}

class TechnicianAppointmentNavigateToToDoActionState extends TechnicianServiceRequestActionState{}

class TechnicianAppointmentNavigateToTechnicianAccountHomeActionState extends TechnicianServiceRequestActionState{}




