part of 'customer_service_request_bloc.dart';

@immutable
abstract class CustomerServiceRequestState {}
abstract class CustomerServiceRequestActionState extends CustomerServiceRequestState{}

class CustomerServiceRequestInitial extends CustomerServiceRequestState {}

class CustomerAppointmentSuccessActionState
    extends CustomerServiceRequestActionState {
  String sucess;
  CustomerAppointmentSuccessActionState({required this.sucess});
}

class CustomerAppointmentUnSuccessfulActionState
    extends CustomerServiceRequestActionState {
  String failure;
  CustomerAppointmentUnSuccessfulActionState({required this.failure});
}

class CustomerServiceRequestIntState extends CustomerServiceRequestState {
  List<CustomerServiceRequestModel> technicianCredential;
  CustomerServiceRequestIntState({required this.technicianCredential});
}

class CustomerServiceRequestSucssesfullyUpdatedActionState extends CustomerServiceRequestActionState{
  String sucess;
  CustomerServiceRequestSucssesfullyUpdatedActionState({required this.sucess});
}

class CustomerServiceRequestFailedToUpdateActionState extends CustomerServiceRequestActionState{
  String failure;
  CustomerServiceRequestFailedToUpdateActionState({required this.failure});
}

class CustomerServiceRequestNoDataState extends CustomerServiceRequestActionState{}

class CustomerServiceRequestErrorActionState extends CustomerServiceRequestActionState{
  String error;
  CustomerServiceRequestErrorActionState({required this.error});
}

class CustomerServiceRequestSucssesfullyDeletedActionState extends CustomerServiceRequestActionState{
  String sucess;
  CustomerServiceRequestSucssesfullyDeletedActionState({required this.sucess});
}

class CustomerServiceRequestFailedToDeleteActionState extends CustomerServiceRequestActionState{
  String failure;
  CustomerServiceRequestFailedToDeleteActionState({required this.failure});
}