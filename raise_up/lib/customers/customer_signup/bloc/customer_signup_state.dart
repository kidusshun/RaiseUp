part of 'customer_signup_bloc.dart';

@immutable
abstract class CustomerSignupState {}

abstract class CustomerSignupActionState extends CustomerSignupState {}

class CustomerSignupInitial extends CustomerSignupState {}

class CustomerSignupLoadingActionState extends CustomerSignupActionState {}

class CustomerSignUpSucessActionState extends CustomerSignupActionState {
  String sucess;
  CustomerSignUpSucessActionState({required this.sucess});
}

class CustomerSignupNavigateToLogInState extends CustomerSignupActionState {}

class CustomerSignUpfailedActionState extends CustomerSignupActionState {
  String failure;
  CustomerSignUpfailedActionState({required this.failure});
}

class CustomerSignUpConfarmationPasswordIncorrectState
    extends CustomerSignupState {}

class CustomerSignUpConfarmationPasswordCorrectState
    extends CustomerSignupState {}
