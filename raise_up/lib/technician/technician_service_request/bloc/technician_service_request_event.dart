part of 'technician_service_request_bloc.dart';

@immutable
abstract class TechnicianServiceRequestEvent {}

class TechnicianServiceRequestTechnicianAccountNavigationButtonClickedEvent extends TechnicianServiceRequestEvent{

}

class TechnicianAppointmentSetEvent extends TechnicianServiceRequestEvent{
  TechnicianAppointment appointment;
  TechnicianAppointmentSetEvent({required this.appointment});
}

class TechnicianServiceRequestHomeNavigationButtonClickedEvent extends TechnicianServiceRequestEvent{

}

class TechnicianServiceRequestRefreshButtonClickedEvent extends TechnicianServiceRequestEvent{

}

class TechnicianServiceRequestToDoNavigationButtonClickedEvent extends TechnicianServiceRequestEvent{

}
