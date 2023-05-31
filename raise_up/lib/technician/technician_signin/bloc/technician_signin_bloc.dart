import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../technician_signup/model/technician_credential_model.dart';
import '../model/technician_confirmation_credential_model.dart';
import '../repository/technician_confirmation_credential_repository.dart';

part 'technician_signin_event.dart';
part 'technician_signin_state.dart';

class TechnicianSigninBloc extends Bloc<TechnicianSigninEvent, TechnicianSigninState> {
  Map<String,String> technicianConfirmationCredentials={};
  TechnicianSigninBloc() : super(TechnicianSigninInitial()) {
    on<TechnicianSigninEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<TechnicianSigninEmailInputEvent>(technicianSigninEmailInputEvent);
    on<TechnicianSigninPasswordInputEvent>(technicianSigninPasswordInputEvent);
    on<TechnicianSigninLoginButtonClickedEvent>(technicianSigninLoginButtonClickedEvent);

  }

  FutureOr<void> technicianSigninEmailInputEvent(TechnicianSigninEmailInputEvent event, Emitter<TechnicianSigninState> emit) {
    technicianConfirmationCredentials["email"]=event.email;
  }

  FutureOr<void> technicianSigninPasswordInputEvent(TechnicianSigninPasswordInputEvent event, Emitter<TechnicianSigninState> emit) {
    technicianConfirmationCredentials["password"]=event.password;
  }

  Future<FutureOr<void>> technicianSigninLoginButtonClickedEvent(TechnicianSigninLoginButtonClickedEvent event, Emitter<TechnicianSigninState> emit) async {
    TechnicianConfirmationCredential technicianConfirmationCredential=TechnicianConfirmationCredential(email: technicianConfirmationCredentials['email']!, password: technicianConfirmationCredentials['password']!);
    emit(TechnicianSigninLoadingActionState());
    String response= await TechnicianConfirmationCredentialRepositoryimpl().confirmTechnicianUser(technicianConfirmationCredential);
    if (response=="confirmed Successfully"){
      emit(TechnicianSigninSucessActionState(sucess: response));
    }
    else if (response!="confirmed Successfully"){
      emit(TechnicianSigninFailedActionState(failure: response));
    }
    
  }
}
