import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'technician_appointments_event.dart';
part 'technician_appointments_state.dart';

class TechnicianAppointmentsBloc extends Bloc<TechnicianAppointmentsEvent, TechnicianAppointmentsState> {
  TechnicianAppointmentsBloc() : super(TechnicianAppointmentsInitial()) {
    on<TechnicianAppointmentsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<TechnicianAppointmentsCustomerCardClickedEvent>(technicianAppointmentsCustomerCardClickedEvent);
  }

  FutureOr<void> technicianAppointmentsCustomerCardClickedEvent(TechnicianAppointmentsCustomerCardClickedEvent event, Emitter<TechnicianAppointmentsState> emit) {
    
  }
}
