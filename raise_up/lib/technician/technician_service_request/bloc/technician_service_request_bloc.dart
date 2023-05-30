import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/technician_appointment_model.dart';
import 'package:raise_up/technician/technician_service_request/repository/technician_appointment_repository.dart';

part 'technician_service_request_event.dart';
part 'technician_service_request_state.dart';

class TechnicianServiceRequestBloc
    extends Bloc<TechnicianServiceRequestEvent, TechnicianServiceRequestState> {
  TechnicianServiceRequestBloc() : super(TechnicianServiceRequestInitial()) {
    on<TechnicianServiceRequestCustomerAppointmentClickedEvent>(
        technicianServiceRequestCustomerAppointmentClickedEvent);
    on<TechnicianServiceRequestCustomerProfileClickedEvent>(
        technicianServiceRequestCustomerProfileClickedEvent);
    on<TechnicianAppointmentSetEvent>(technicianAppointmentSetEvent);
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

  Future<FutureOr<void>> technicianAppointmentSetEvent(TechnicianAppointmentSetEvent event, Emitter<TechnicianServiceRequestState> emit) async {
    emit(TechnicianAppointmentLoadingState());
    await TechnicianAppointmentRepositoryimpl().createAppointment(event.appointment);
    emit(TechnicianAppointmentSuccessState());
  }
}
