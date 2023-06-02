part of 'technician_service_request_bloc.dart';

@immutable
abstract class TechnicianServiceRequestState {}

abstract class TechnicianServiceRequestActionState extends TechnicianServiceRequestState {}

class TechnicianServiceRequestInitial extends TechnicianServiceRequestState {}

class TechnicianServiceRequestIntState extends TechnicianServiceRequestState {
  List<TechnicianCustomerServiceRequest> customerCredential;
  TechnicianServiceRequestIntState({required this.customerCredential});
}

class TechnicianAppointmentLoadingActionState extends TechnicianServiceRequestActionState{}

class TechnicianAppointmentSuccessActionState extends TechnicianServiceRequestActionState{
  String sucess;
  TechnicianAppointmentSuccessActionState({required this.sucess});
}

class TechnicianAppointmentUnSuccessfulActionState extends TechnicianServiceRequestActionState{
  String failure;
  TechnicianAppointmentUnSuccessfulActionState({required this.failure});
}

class TechnicianAppointmentNavigateToHomeActionState extends TechnicianServiceRequestActionState{}

class TechnicianAppointmentNavigateToToDoActionState extends TechnicianServiceRequestActionState{}

class TechnicianAppointmentNavigateToTechnicianAccountHomeActionState extends TechnicianServiceRequestActionState{}

class TechnicianServiceRequestErrorActionState extends TechnicianServiceRequestActionState{
  dynamic error;
  TechnicianServiceRequestErrorActionState({this.error});
}


