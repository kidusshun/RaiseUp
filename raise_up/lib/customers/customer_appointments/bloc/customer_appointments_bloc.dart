import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/customer_appointments_model.dart';
import '../repository/customer_appointments_repository.dart';

part 'customer_appointments_event.dart';
part 'customer_appointments_state.dart';

class CustomerAppointmentsBloc
    extends Bloc<CustomerAppointmentsEvent, CustomerAppointmentsState> {
  CustomerAppointmentsBloc() : super(CustomerAppointmentsInitial()) {
    on<CustomerAppointmentsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CustomerAppointmentsCustomerCardClickedEvent>(
        customerAppointmentsCustomerCardClickedEvent);
    on<CustomerAppointInitialEvent>(customerAppointInitialEvent);
  }

  FutureOr<void> customerAppointmentsCustomerCardClickedEvent(
      CustomerAppointmentsCustomerCardClickedEvent event,
      Emitter<CustomerAppointmentsState> emit) {}

  Future<FutureOr<void>> customerAppointInitialEvent(
      CustomerAppointInitialEvent event,
      Emitter<CustomerAppointmentsState> emit) async {
    emit(CustomerAppointmentsLoadingActionState());
    dynamic response =
        await CustomerAppointmentsRepositoryImpl().getAppointments();
    if (response.length==0){
      emit(CustomerAppointmentsNoDataState());
    }
    else if (response[0].runtimeType != String) {
      emit(CustomerAppointmentsInitState(customerCredential: response));
    } else {
      emit(CustomerAppointmentsErrorActionState(error: response));
    }
  }
}
