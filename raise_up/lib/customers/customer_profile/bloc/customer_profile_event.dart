part of 'customer_profile_bloc.dart';

@immutable
abstract class CustomerProfileEvent {}

class CustomerHistoryInitialEvent extends CustomerProfileEvent {}

class CustomerHistoryInitialNameEvent extends CustomerProfileEvent{}
