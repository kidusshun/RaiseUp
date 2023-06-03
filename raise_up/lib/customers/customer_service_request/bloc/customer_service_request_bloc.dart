import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/customer_service_request_delete_model.dart';
import '../model/customer_service_request_model.dart';
import '../model/customer_service_request_update_model.dart';
import '../repository/customer_service_request_delete_repository.dart';
import '../repository/customer_service_request_repository.dart';
import '../repository/customer_service_request_update_repository.dart';

part 'customer_service_request_event.dart';
part 'customer_service_request_state.dart';

class CustomerServiceRequestBloc extends Bloc<CustomerServiceRequestEvent, CustomerServiceRequestState> {
  CustomerServiceRequestBloc() : super(CustomerServiceRequestInitial()) {
    on<CustomerServiceRequestEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CustomerServiceRequestTechnicianCardClickedEvent>(customerServiceRequestTechnicianCardClickedEvent);
    on<CustomerServiceRequestInitialEvent>(customerServiceRequestInitialEvent);
    on<CustomerServiceRequestDeleteButtonClickedEvent>(customerServiceRequestDeleteButtonClickedEvent);
  }

  Future<FutureOr<void>> customerServiceRequestTechnicianCardClickedEvent(CustomerServiceRequestTechnicianCardClickedEvent event, Emitter<CustomerServiceRequestState> emit) async {
    dynamic response=await CustomerServiceRequestUpdateRepositoryImpl().updateServiceRequests(event.updatedServiceRequest);
        dynamic responseRef= await CustomerServiceRequestRepositoryImpl().getServiceRequests();
        if (response=="Sucessfully Updated"){
          emit(CustomerServiceRequestSucssesfullyUpdatedActionState(sucess: response));
          emit(CustomerServiceRequestIntState(technicianCredential: responseRef));
        }else{
          emit(CustomerServiceRequestFailedToUpdateActionState(failure: response));
        }
  }

  Future<FutureOr<void>> customerServiceRequestInitialEvent(CustomerServiceRequestInitialEvent event, Emitter<CustomerServiceRequestState> emit) async {
    dynamic response= await CustomerServiceRequestRepositoryImpl().getServiceRequests();
    // print(response);
    // print("hi");
    if (response.length==0){
      emit(CustomerServiceRequestNoDataState());
    }
    else if (response[0].runtimeType != String) {
      emit(CustomerServiceRequestIntState(technicianCredential: response));
    } else {
      emit(CustomerServiceRequestErrorActionState(error: response[0]));
    }
  }
  Future<FutureOr<void>> customerServiceRequestDeleteButtonClickedEvent(CustomerServiceRequestDeleteButtonClickedEvent event, Emitter<CustomerServiceRequestState> emit) async {
    dynamic response= await CustomerServiceRequestDeleteRepositoryImpl().deleteAppointment(event.serviceRequestDelete);
    dynamic responseRef= await CustomerServiceRequestRepositoryImpl().getServiceRequests();
    if (response=="Sucessfully Deleted"){
      emit(CustomerServiceRequestSucssesfullyDeletedActionState(sucess: response));
      emit(CustomerServiceRequestIntState(technicianCredential: responseRef));
    }else{
      emit(CustomerServiceRequestFailedToDeleteActionState(failure:response));
    }
  }
}
