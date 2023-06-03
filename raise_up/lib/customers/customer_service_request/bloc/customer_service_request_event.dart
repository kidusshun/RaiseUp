part of 'customer_service_request_bloc.dart';

@immutable
abstract class CustomerServiceRequestEvent {}

class CustomerServiceRequestInitialEvent extends CustomerServiceRequestEvent {}

class CustomerServiceRequestTechnicianCardClickedEvent
    extends CustomerServiceRequestEvent {
      CustomerServiceRequestUpdate updatedServiceRequest;
  CustomerServiceRequestTechnicianCardClickedEvent({required this.updatedServiceRequest});
}

class CustomerServiceRequestDeleteButtonClickedEvent extends CustomerServiceRequestEvent{
  CustomerServiceRequestDelete serviceRequestDelete;
  CustomerServiceRequestDeleteButtonClickedEvent({required this.serviceRequestDelete});
}