part of 'technician_service_request_bloc.dart';

@immutable
abstract class TechnicianServiceRequestState {}

abstract class TechnicianServiceRequestActionState
    extends TechnicianServiceRequestState {}

class TechnicianServiceRequestSuccessState
    extends TechnicianServiceRequestState {}

class TechnicianServiceRequestInitial extends TechnicianServiceRequestState {}

class TechnicianServiceRequestNavigateToAppointmentApprovalState
    extends TechnicianServiceRequestActionState {}

class TechnicianServiceRequestNavigateToProfileState
    extends TechnicianServiceRequestActionState {}

class TechnicianAppointmentLoadingState extends TechnicianServiceRequestActionState{}

class TechnicianAppointmentSuccessState extends TechnicianServiceRequestActionState{}


