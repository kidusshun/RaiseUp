import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:raise_up/technician/technician_signup/model/technician_credential_model.dart';
import 'package:raise_up/technician/technician_signup/repository/technician_credential_repository.dart';

part 'technician_signup_event.dart';
part 'technician_signup_state.dart';

class TechnicianSignupBloc
    extends Bloc<TechnicianSignupEvent, TechnicianSignupState> {
  Map<String, String> technicianCredentials = {};

  TechnicianSignupBloc() : super(TechnicianSignupInitial()) {
    on<TechnicianSignupEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<TechnicianSignupEmailInputEvent>(technicianSignupEmailInputEvent);
    on<TechnicianSignupNameInputEvent>(technicianSignupNameInputEvent);
    on<TechnicianSignupPasswordInputEvent>(technicianSignupPasswordInputEvent);
    on<TechnicianSignupConfirmationPasswordInputEvent>(
        technicianSignupConfirmationPasswordInputEvent);
    on<TechnicianSignupSignupButtonClickedEvent>(
        technicianSignupSignupButtonClickedEvent);
  }

  FutureOr<void> technicianSignupEmailInputEvent(
      TechnicianSignupEmailInputEvent event,
      Emitter<TechnicianSignupState> emit) {
    technicianCredentials["email"] = event.email;
  }

  FutureOr<void> technicianSignupNameInputEvent(
      TechnicianSignupNameInputEvent event,
      Emitter<TechnicianSignupState> emit) {
    technicianCredentials["name"] = event.name;
  }

  FutureOr<void> technicianSignupPasswordInputEvent(
      TechnicianSignupPasswordInputEvent event,
      Emitter<TechnicianSignupState> emit) {
    technicianCredentials["password"] = event.password;
  }

  FutureOr<void> technicianSignupConfirmationPasswordInputEvent(
      TechnicianSignupConfirmationPasswordInputEvent event,
      Emitter<TechnicianSignupState> emit) {
    technicianCredentials["confirmationPassword"] = event.confirmationPassword;
    // print(technicianCredentials["confirmationPassword"]);
    // print(technicianCredentials["password"]);
    if (technicianCredentials["confirmationPassword"] !=
        technicianCredentials["password"]) {
      emit(TechnicianSignUpConfarmationPasswordIncorrectState());
      // print("incorrect confirmation password");
    } else if (technicianCredentials["confirmationPassword"] ==
        technicianCredentials["password"]) {
      emit(TechnicianSignUpConfarmationPasswordCorrectState());
    }
  }

  Future<void> technicianSignupSignupButtonClickedEvent(
      TechnicianSignupSignupButtonClickedEvent event,
      Emitter<TechnicianSignupState> emit) async {
    if (technicianCredentials["confirmationPassword"] ==
        technicianCredentials["password"]) {
      TechnicianCredential technicianCredential = TechnicianCredential(
          email: technicianCredentials['email']!,
          name: technicianCredentials['name']!,
          password: technicianCredentials['password']!);
      String response = await TechnicianCredentialRepositoryimpl()
          .createTechnicianUser(technicianCredential);
      if (response == "Created Successfully") {
        emit(TechnicianSignUpSucessActionState(sucess: "Created Successfully"));
      } else if (response == "Account with this email already exists") {
        emit(TechnicianSignUpfailedActionState(
            failure: "Account with this email already exists"));
      } else if (response == "Use a correct email") {
        emit(TechnicianSignUpfailedActionState(failure: "Use a correct email"));
      } else if (response == "Unknown Problem occured please try again later") {
        emit(TechnicianSignUpfailedActionState(
            failure: "Unknown Problem occured please try again later"));
      }
    }
  }

  FutureOr<void> technicianSignupLogInButtonClickedEvent(
      TechnicianSignupLogInButtonClickedEvent event,
      Emitter<TechnicianSignupState> emit) {
  }
}
