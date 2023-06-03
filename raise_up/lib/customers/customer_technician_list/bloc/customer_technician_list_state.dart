part of 'customer_technician_list_bloc.dart';

@immutable
abstract class CustomerTechnicianListState {}

abstract class CustomerTechnicianListActionState
    extends CustomerTechnicianListState {}

class CustomerTechnicianListInitial extends CustomerTechnicianListState {}

class CustomerTechnicianListInitState extends CustomerTechnicianListState {
  List<TechnicianCredential> technicianCredential;
  CustomerTechnicianListInitState({required this.technicianCredential});
}

class CustomerTechnicianListErrorActionState
    extends CustomerTechnicianListActionState {
  String error;
  CustomerTechnicianListErrorActionState({required this.error});
}

class customerTechnicianListBookButtonClickedSucessActionState
    extends CustomerTechnicianListActionState {
  String sucess;
  customerTechnicianListBookButtonClickedSucessActionState(
      {required this.sucess});
}

class customerTechnicianListBookButtonClickedFailureActionState
    extends CustomerTechnicianListActionState {
  String failure;
  customerTechnicianListBookButtonClickedFailureActionState(
      {required this.failure});
}

class CustomerTechnicianListNavigateToHomeState
    extends CustomerTechnicianListActionState {}
