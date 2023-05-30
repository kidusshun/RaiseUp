part of 'technician_signin_bloc.dart';

@immutable
abstract class TechnicianSigninState {}
abstract class TechnicianSigninActionState extends TechnicianSigninState{}


class TechnicianSigninInitial extends TechnicianSigninState {}

class TechnicianSigninSucessActionState extends TechnicianSigninActionState{
  String sucess;
  TechnicianSigninSucessActionState({required this.sucess});
}

class TechnicianSigninFailedActionState extends TechnicianSigninActionState{
  String faliure;
  TechnicianSigninFailedActionState({required this.faliure});
}

class TechnicianSigninLoadingActionState extends TechnicianSigninActionState{

}