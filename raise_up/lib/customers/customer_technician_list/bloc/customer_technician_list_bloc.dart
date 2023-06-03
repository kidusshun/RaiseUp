import 'dart:async';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:raise_up/customers/customer_technician_list/model/technician_credential_model.dart';
import 'package:raise_up/customers/customer_technician_list/model/customer_service_request_model.dart';

import '../repository/customer_date_selection_repository.dart';
import '../repository/technician_credential_repository.dart';

part 'customer_technician_list_event.dart';
part 'customer_technician_list_state.dart';

class CustomerTechnicianListBloc
    extends Bloc<CustomerTechnicianListEvent, CustomerTechnicianListState> {
  CustomerTechnicianListBloc() : super(CustomerTechnicianListInitial()) {
    on<CustomerTechnicianListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CustomerTechnicianListInitEvent>(customerTechnicianListInitEvent);
    on<CustomerTechnicianListHomeButtonClickedEvent>(
        customerTechnicianListHomeButtonClickedEvent);

    on<CustomerTechnicianListBookButtonClickedEvent>(
        customerTechnicianListBookButtonClickedEvent);
  }

  Future<FutureOr<void>> customerTechnicianListInitEvent(
      CustomerTechnicianListInitEvent event,
      Emitter<CustomerTechnicianListState> emit) async {
    dynamic response =
        await TechnicianCredentialRepositoryImpl().getTechnicians();
    if (response.length==0){
      emit(TechnicianListNoDataState());
    }
    else if (response[0].runtimeType != String) {
      emit(CustomerTechnicianListInitState(technicianCredential: response));
    } else {
      emit(CustomerTechnicianListErrorActionState(error: response[0]));
    }
  }

  Future<FutureOr<void>> customerTechnicianListBookButtonClickedEvent(
      CustomerTechnicianListBookButtonClickedEvent event,
      Emitter<CustomerTechnicianListState> emit) async {
    CustomerServiceRequest serviceRequest = CustomerServiceRequest(
        technicianId: event.technicianId,
        notes: event.notes,
        isoDateString: event.iso);
    String response =
        await CustomerDateSeclectionRepositoryImpl().setDate(serviceRequest);
    if (response == "Successfully Recoreded!") {
      emit(customerTechnicianListBookButtonClickedSucessActionState(
          sucess: response));
    } else {
      emit(customerTechnicianListBookButtonClickedFailureActionState(
          failure: response));
    }
  }

  FutureOr<void> customerTechnicianListHomeButtonClickedEvent(
      CustomerTechnicianListHomeButtonClickedEvent event,
      Emitter<CustomerTechnicianListState> emit) {
    emit(CustomerTechnicianListNavigateToHomeState());
  }
}
