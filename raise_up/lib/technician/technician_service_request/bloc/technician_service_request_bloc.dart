import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'technician_service_request_event.dart';
part 'technician_service_request_state.dart';

class TechnicianServiceRequestBloc
    extends Bloc<TechnicianServiceRequestEvent, TechnicianServiceRequestState> {
  TechnicianServiceRequestBloc() : super(TechnicianServiceRequestInitial()) {
    on<TechnicianServiceRequestCustomerAppointmentClickedEvent>(
        technicianServiceRequestCustomerAppointmentClickedEvent);
    on<TechnicianServiceRequestCustomerProfileClickedEvent>(
        technicianServiceRequestCustomerProfileClickedEvent);
  }

  FutureOr<void> technicianServiceRequestCustomerAppointmentClickedEvent(
      TechnicianServiceRequestCustomerAppointmentClickedEvent event,
      Emitter<TechnicianServiceRequestState> emit) {
    emit(TechnicianServiceRequestNavigateToAppointmentApprovalState());
  }

  FutureOr<void> technicianServiceRequestCustomerProfileClickedEvent(
      TechnicianServiceRequestCustomerProfileClickedEvent event,
      Emitter<TechnicianServiceRequestState> emit) {
    emit(TechnicianServiceRequestNavigateToProfileState());
  }
}
