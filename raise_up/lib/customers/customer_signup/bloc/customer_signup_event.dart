part of 'customer_signup_bloc.dart';

@immutable
abstract class CustomerSignupEvent {}

class CustomerSignupEmailInputEvent extends CustomerSignupEvent {
  String email;
  CustomerSignupEmailInputEvent({required this.email});
}

class CustomerSignupNameInputEvent extends CustomerSignupEvent {
  String name;
  CustomerSignupNameInputEvent({required this.name});
}

class CustomerSignupPasswordInputEvent extends CustomerSignupEvent {
  String password;
  CustomerSignupPasswordInputEvent({required this.password});
}

class CustomerSignupConfirmationPasswordInputEvent
    extends CustomerSignupEvent {
  String confirmationPassword;
  CustomerSignupConfirmationPasswordInputEvent(
      {required this.confirmationPassword});
}

class CustomerSignupSignupButtonClickedEvent extends CustomerSignupEvent {}

