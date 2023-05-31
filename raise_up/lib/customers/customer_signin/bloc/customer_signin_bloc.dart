import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/customer_confirmation_credential_model.dart';
import '../repository/customer_confirmation_credential_repository.dart';

part 'customer_signin_event.dart';
part 'customer_signin_state.dart';

class CustomerSigninBloc extends Bloc<CustomerSigninEvent, CustomerSigninState> {
  Map<String,String> customerConfirmationCredentials={};
  CustomerSigninBloc() : super(CustomerSigninInitial()) {
    on<CustomerSigninEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CustomerSigninEmailInputEvent>(customerSigninEmailInputEvent);
    on<CustomerSigninPasswordInputEvent>(customerSigninPasswordInputEvent);
    on<CustomerSigninLoginButtonClickedEvent>(customerSigninLoginButtonClickedEvent);

  }

  FutureOr<void> customerSigninEmailInputEvent(CustomerSigninEmailInputEvent event, Emitter<CustomerSigninState> emit) {
    customerConfirmationCredentials["email"]=event.email;
  }

  FutureOr<void> customerSigninPasswordInputEvent(CustomerSigninPasswordInputEvent event, Emitter<CustomerSigninState> emit) {
    customerConfirmationCredentials["password"]=event.password;
  }

  Future<FutureOr<void>> customerSigninLoginButtonClickedEvent(CustomerSigninLoginButtonClickedEvent event, Emitter<CustomerSigninState> emit) async {
    CustomerConfirmationCredential customerConfirmationCredential=CustomerConfirmationCredential(email: customerConfirmationCredentials['email']!, password: customerConfirmationCredentials['password']!);
    emit(CustomerSigninLoadingActionState());
    String response= await CustomerConfirmationCredentialRepositoryimpl().confirmCustomerUser(customerConfirmationCredential);
    if (response=="confirmed Successfully"){
      emit(CustomerSigninSucessActionState(sucess: response));
    }
    else if (response!="confirmed Successfully"){
      emit(CustomerSigninFailedActionState(failure: response));
    }
    
  }
}

