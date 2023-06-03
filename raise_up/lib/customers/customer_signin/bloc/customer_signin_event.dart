part of 'customer_signin_bloc.dart';

@immutable
abstract class CustomerSigninEvent {}

class CustomerSigninEmailInputEvent extends CustomerSigninEvent {
  String email;
  CustomerSigninEmailInputEvent({required this.email});
}

class CustomerSigninPasswordInputEvent extends CustomerSigninEvent {
  String password;
  CustomerSigninPasswordInputEvent({required this.password});
}

class CustomerSigninLoginButtonClickedEvent extends CustomerSigninEvent {}

class CustomerSigninSignUpButtonClickedEvent extends CustomerSigninEvent {}
