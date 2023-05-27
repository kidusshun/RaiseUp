part of 'technician_service_request_bloc.dart';

@immutable
abstract class TechnicianServiceRequestEvent {}

class TechnicianServiceRequestCustomerAppointmentClickedEvent
    extends TechnicianServiceRequestEvent {}

class TechnicianServiceRequestCustomerProfileClickedEvent
    extends TechnicianServiceRequestEvent {}
