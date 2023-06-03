part of 'customer_appointments_bloc.dart';

@immutable
abstract class CustomerAppointmentsState {}

abstract class CustomerAppointmentsActionState
    extends CustomerAppointmentsState {}

class CustomerAppointmentsInitial extends CustomerAppointmentsState {}

class CustomerAppointmentsInitState extends CustomerAppointmentsState {
  List<CustomerAppointments> customerCredential;
  CustomerAppointmentsInitState({required this.customerCredential});
}

class CustomerAppointmentsLoadingActionState
    extends CustomerAppointmentsState {}

class CustomerAppointmentsErrorActionState
    extends CustomerAppointmentsActionState {
  String error;
  CustomerAppointmentsErrorActionState({required this.error});
}
