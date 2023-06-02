import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:raise_up/technician/technician_account_information/bloc/technician_account_information_bloc.dart';

import '../model/technician_appointment_model.dart';
import 'package:raise_up/technician/technician_service_request/repository/technician_appointment_repository.dart';

import '../model/technician_customer_service_request.dart';
import '../repository/technician_customer_service_request_repository.dart';

part 'technician_service_request_event.dart';
part 'technician_service_request_state.dart';

class TechnicianServiceRequestBloc
    extends Bloc<TechnicianServiceRequestEvent, TechnicianServiceRequestState> {
  TechnicianServiceRequestBloc() : super(TechnicianServiceRequestInitial()) {
    on<TechnicianAppointmentSetEvent>(technicianAppointmentSetEvent);
    on<TechnicianAppointmentInitialEvent>(technicianAppointmentInitialEvent);
  }

  Future<FutureOr<void>> technicianAppointmentSetEvent(TechnicianAppointmentSetEvent event, Emitter<TechnicianServiceRequestState> emit) async {
    emit(TechnicianAppointmentLoadingActionState());
    String response =await TechnicianAppointmentRepositoryimpl().createAppointment(event.appointment);
    print(response);
    if (response=="Successfully Appointed!"){
      print("hi");
      emit(TechnicianAppointmentSuccessActionState(sucess: response));
    }else{
      emit(TechnicianAppointmentUnSuccessfulActionState(failure: response));
    }
    
  }

  Future<FutureOr<void>> technicianAppointmentInitialEvent(TechnicianAppointmentInitialEvent event, Emitter<TechnicianServiceRequestState> emit) async {

    dynamic response= await  TechnicianCustomerServiceRequestRepositoryImpl().getCustomers();
    if (response[0].runtimeType!=String){
      // print("cc");
      emit(TechnicianServiceRequestIntState(customerCredential:response));
    }
    else{
      emit(TechnicianServiceRequestErrorActionState(error:response[0]));
    }
  }
}
