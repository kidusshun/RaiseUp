import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/technician_appointments_model.dart';
import '../repository/technician_appointments_repository.dart';

part 'technician_appointments_event.dart';
part 'technician_appointments_state.dart';

class TechnicianAppointmentsBloc extends Bloc<TechnicianAppointmentsEvent, TechnicianAppointmentsState> {
  TechnicianAppointmentsBloc() : super(TechnicianAppointmentsInitial()) {
    on<TechnicianAppointmentsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<TechnicianAppointmentsCustomerCardClickedEvent>(technicianAppointmentsCustomerCardClickedEvent);
    on<TechnicianAppointInitialEvent>(technicianAppointInitialEvent);
  }

  FutureOr<void> technicianAppointmentsCustomerCardClickedEvent(TechnicianAppointmentsCustomerCardClickedEvent event, Emitter<TechnicianAppointmentsState> emit) {
    
  }

  Future<FutureOr<void>> technicianAppointInitialEvent(TechnicianAppointInitialEvent event, Emitter<TechnicianAppointmentsState> emit) async {
    emit(TechnicianAppointmentsLoadingActionState());
    dynamic response= await TechnicianAppointmentsRepositoryImpl().getAppointments();
    if (response[0].runtimeType!=String){
      emit(TechnicianAppointmentsInitState(customerCredential: response));
  }else{
    emit(TechnicianAppointmentsErrorActionState(error: response));
    }
  }
}