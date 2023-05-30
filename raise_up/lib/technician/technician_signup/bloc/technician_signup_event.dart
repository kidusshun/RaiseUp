part of 'technician_signup_bloc.dart';

@immutable
abstract class TechnicianSignupEvent {}

class TechnicianSignupEmailInputEvent extends TechnicianSignupEvent {
  String email;
  TechnicianSignupEmailInputEvent({required this.email});
}

class TechnicianSignupNameInputEvent extends TechnicianSignupEvent {
  String name;
  TechnicianSignupNameInputEvent({required this.name});
}

class TechnicianSignupPasswordInputEvent extends TechnicianSignupEvent {
  String password;
  TechnicianSignupPasswordInputEvent({required this.password});
}

class TechnicianSignupConfirmationPasswordInputEvent
    extends TechnicianSignupEvent {
  String confirmationPassword;
  TechnicianSignupConfirmationPasswordInputEvent(
      {required this.confirmationPassword});
}

class TechnicianSignupSignupButtonClickedEvent extends TechnicianSignupEvent {}
