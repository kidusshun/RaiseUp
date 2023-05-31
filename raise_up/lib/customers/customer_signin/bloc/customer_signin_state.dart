part of 'customer_signin_bloc.dart';

@immutable
abstract class CustomerSigninState {}
abstract class CustomerSigninActionState extends CustomerSigninState{}

class CustomerSigninInitial extends CustomerSigninState {}

class CustomerSigninSucessActionState extends CustomerSigninActionState{
  String sucess;
  CustomerSigninSucessActionState({required this.sucess});
}

class CustomerSigninFailedActionState extends CustomerSigninActionState{
  String failure;
  CustomerSigninFailedActionState({required this.failure});
}

class CustomerSigninLoadingActionState extends CustomerSigninActionState{

}