part of 'customer_profile_bloc.dart';

@immutable
abstract class CustomerProfileState {}
abstract class CustomerProfileActionState extends CustomerProfileState {}

class CustomerProfileInitial extends CustomerProfileState {}

class CustomerProfileInitialState extends CustomerProfileState {
  List<CustomerProfileHistory> history;
  CustomerProfileInitialState({required this.history});
}

class CustomerProfileFailedToLoadHistoryActionState extends CustomerProfileActionState {
  String failure;
  CustomerProfileFailedToLoadHistoryActionState({required this.failure});
}

class CustomerProfileNoHistoryState extends CustomerProfileState{}

class CustomerProfileNameLoadedState extends CustomerProfileState{
  String profileName;
  CustomerProfileNameLoadedState({required this.profileName});
}
