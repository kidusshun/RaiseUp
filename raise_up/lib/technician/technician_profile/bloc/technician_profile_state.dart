part of 'technician_profile_bloc.dart';

@immutable
abstract class TechnicianProfileState {}

class TechnicianProfileInitial extends TechnicianProfileState {}

abstract class TechnicianProfileActionState extends TechnicianProfileState {}

class TechnicianProfileLoadingState extends TechnicianProfileState {}

class TechnicianProfileNavigateToHomeState
    extends TechnicianProfileActionState {}

class TechnicianProfileNavigateToTodoState
    extends TechnicianProfileActionState {}

class TechnicianprofileEditedNameState extends TechnicianProfileActionState {}

class TechnicianProfileErrorState extends TechnicianProfileState {}
