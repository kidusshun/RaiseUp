import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Repository/customer_credential_repository.dart';
import '../model/customer_credential_model.dart';

part 'customer_signup_event.dart';
part 'customer_signup_state.dart';

class CustomerSignupBloc extends Bloc<CustomerSignupEvent, CustomerSignupState> {
  Map<String,String> customerCredentials={};
  CustomerSignupBloc() : super(CustomerSignupInitial()) {
    on<CustomerSignupEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CustomerSignupEmailInputEvent>(customerSignupEmailInputEvent);
    on<CustomerSignupNameInputEvent>(customerSignupNameInputEvent);
    on<CustomerSignupPasswordInputEvent>(customerSignupPasswordInputEvent);
    on<CustomerSignupConfirmationPasswordInputEvent>(
        customerSignupConfirmationPasswordInputEvent);
    on<CustomerSignupSignupButtonClickedEvent>(
        customerSignupSignupButtonClickedEvent);
  }

  FutureOr<void> customerSignupEmailInputEvent(CustomerSignupEmailInputEvent event, Emitter<CustomerSignupState> emit) {
    customerCredentials["email"] = event.email;
  }

  FutureOr<void> customerSignupNameInputEvent(CustomerSignupNameInputEvent event, Emitter<CustomerSignupState> emit) {
    customerCredentials["name"] = event.name;
  }

  FutureOr<void> customerSignupPasswordInputEvent(CustomerSignupPasswordInputEvent event, Emitter<CustomerSignupState> emit) {
    customerCredentials["password"] = event.password;
  }

  FutureOr<void> customerSignupConfirmationPasswordInputEvent(CustomerSignupConfirmationPasswordInputEvent event, Emitter<CustomerSignupState> emit) {
    customerCredentials["confirmationPassword"] = event.confirmationPassword;
    // print(customerCredentials["confirmationPassword"]);
    // print(customerCredentials["password"]);
    if (customerCredentials["confirmationPassword"] !=
        customerCredentials["password"]) {
      emit(CustomerSignUpConfarmationPasswordIncorrectState());
      // print("incorrect confirmation password");
    } else if (customerCredentials["confirmationPassword"] ==
        customerCredentials["password"]) {
      emit(CustomerSignUpConfarmationPasswordCorrectState());
    }
  }

  FutureOr<void> customerSignupSignupButtonClickedEvent(CustomerSignupSignupButtonClickedEvent event, Emitter<CustomerSignupState> emit) async {
    if (customerCredentials["confirmationPassword"] ==
        customerCredentials["password"]) {
      // print("hi");
      CustomerCredential customerCredential = CustomerCredential(
          email: customerCredentials['email']!,
          name: customerCredentials['name']!,
          password: customerCredentials['password']!);
      emit(CustomerSignupLoadingActionState());
      String response = await CustomerCredentialRepositoryimpl()
          .createCustomerUser(customerCredential);
      if (response == "Created Successfully") {
        // print("sucess");
        emit(CustomerSignUpSucessActionState(sucess: "Created Successfully"));
      } else if (response == "Account with this email already exists") {
        // print("Account Already exists");
        emit(CustomerSignUpfailedActionState(
            failure: "Account with this email already exists"));
      } else if (response == "Use a correct email") {
        // print("Use a correct email");
        emit(CustomerSignUpfailedActionState(failure: "Use a correct email"));
      } else if (response == "Unknown Problem occured please try again later") {
        // print("Unknown Problem occured please try again later");
        emit(CustomerSignUpfailedActionState(
            failure: "Unknown Problem occured please try again later"));
      }
    }
  }
}
