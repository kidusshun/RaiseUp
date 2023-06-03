part of 'customer_appointments_bloc.dart';

@immutable
abstract class CustomerAppointmentsEvent {}

class CustomerAppointmentsCustomerCardClickedEvent
    extends CustomerAppointmentsEvent {
  String customerId;
  CustomerAppointmentsCustomerCardClickedEvent({required this.customerId});
}

class CustomerAppointInitialEvent extends CustomerAppointmentsEvent {}
