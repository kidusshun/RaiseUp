part of 'technician_profile_bloc.dart';

// import 'package:raise_up/technician/technician_profile/model/technician_profile_class.dart';
@immutable
abstract class TechnicianProfileState {}

abstract class TechnicianProfileActionState extends TechnicianProfileState {}

class TechnicianProfileInitial extends TechnicianProfileState {}

class TechnicianProfileLoadingState extends TechnicianProfileState {}

class TechnicianProfileLoadedSuccessState extends TechnicianProfileState {
  final TechnicianProfile technicianProfile;

  TechnicianProfileLoadedSuccessState(this.technicianProfile);

  @override
  List<Object?> get props => [technicianProfile];
}

class TechnicianProfileNavigateToHomeState
    extends TechnicianProfileActionState {}

class TechnicianProfileNavigateToTodoState
    extends TechnicianProfileActionState {}

class TechnicianprofileEditedNameState extends TechnicianProfileActionState {}

class TechnicianprofileEditedExpertiseState
    extends TechnicianProfileActionState {}

class TechnicianProfileErrorState extends TechnicianProfileState {}
