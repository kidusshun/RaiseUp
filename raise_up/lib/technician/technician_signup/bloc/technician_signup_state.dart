part of 'technician_signup_bloc.dart';

@immutable
abstract class TechnicianSignupState {}
abstract class TechnicianSignupActionState extends TechnicianSignupState {}


class TechnicianSignupInitial extends TechnicianSignupState {}

class TechnicianSignupLoadingActionState extends TechnicianSignupActionState {}

class TechnicianSignUpSucessActionState extends TechnicianSignupActionState{
  String sucess;
  TechnicianSignUpSucessActionState({required this.sucess});
}

class TechnicianSignUpfailedActionState extends TechnicianSignupActionState{
  String faliure;
  TechnicianSignUpfailedActionState({required this.faliure});
}

class TechnicianSignUpConfarmationPasswordIncorrectState extends TechnicianSignupState{}

class TechnicianSignUpConfarmationPasswordCorrectState extends TechnicianSignupState{}






