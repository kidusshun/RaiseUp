part of 'technician_signin_bloc.dart';

@immutable
abstract class TechnicianSigninEvent {}

class TechnicianSigninEmailInputEvent extends TechnicianSigninEvent{
  String email;
  TechnicianSigninEmailInputEvent({required this.email});
}

class TechnicianSigninPasswordInputEvent extends TechnicianSigninEvent{
  String password;
  TechnicianSigninPasswordInputEvent({required this.password});
}

class TechnicianSigninLoginButtonClickedEvent extends TechnicianSigninEvent{}
