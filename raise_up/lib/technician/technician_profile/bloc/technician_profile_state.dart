part of 'technician_profile_bloc.dart';

@immutable
abstract class TechnicianProfileState {}
abstract class TechnicianProfileActionState extends TechnicianProfileState {}


class TechnicianProfileInitial extends TechnicianProfileState {
}

class TechnicianProfileInitialState extends TechnicianProfileState {
  List<ProfileHistory> history;
  TechnicianProfileInitialState({required this.history});
}

class TechnicianProfileFailedToLoadHistoryActionState extends TechnicianProfileActionState {
  String failure;
  TechnicianProfileFailedToLoadHistoryActionState({required this.failure});
}

class TechnicianProfileNoHistoryState extends TechnicianProfileState{}

class TechnicianProfileNameLoadedState extends TechnicianProfileState{
  String profileName;
  TechnicianProfileNameLoadedState({required this.profileName});
}