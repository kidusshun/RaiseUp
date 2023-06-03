import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/technician_appointment_delete_model.dart';
import '../model/technician_appointments_model.dart';
import '../model/technician_appointments_update_model.dart';
import '../repository/technician_appointments_delete_repository.dart';
import '../repository/technician_appointments_repository.dart';
import '../repository/technician_appointments_update_repository.dart';

part 'technician_appointments_event.dart';
part 'technician_appointments_state.dart';

class TechnicianAppointmentsBloc
    extends Bloc<TechnicianAppointmentsEvent, TechnicianAppointmentsState> {
  TechnicianAppointmentsBloc() : super(TechnicianAppointmentsInitial()) {
    on<TechnicianAppointmentsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<TechnicianAppointmentsCustomerCardClickedEvent>(technicianAppointmentsCustomerCardClickedEvent);
    on<TechnicianAppointInitialEvent>(technicianAppointInitialEvent);
    on<TechnicianAppointmentDeleteButtonClickedEvent>(technicianAppointmentDeleteButtonClickedEvent);
  }

  Future<FutureOr<void>> technicianAppointmentsCustomerCardClickedEvent(
      TechnicianAppointmentsCustomerCardClickedEvent event,
      Emitter<TechnicianAppointmentsState> emit) async {
        dynamic response=await TechnicianAppointmentsUpdateRepositoryImpl().updateAppointments(event.updatedAppointment);
        dynamic responseRef= await TechnicianAppointmentsRepositoryImpl().getAppointments();
        if (response=="Sucessfully Updated"){
          emit(TechnicianAppointmentsSucssesfullyUpdatedActionState(sucess: response));
          emit(TechnicianAppointmentsInitState(customerCredential: responseRef));
        }else{
          emit(TechnicianAppointmentsFailedToUpdateActionState(failure: response));
        }
      }

  Future<FutureOr<void>> technicianAppointInitialEvent(
      TechnicianAppointInitialEvent event,
      Emitter<TechnicianAppointmentsState> emit) async {

    dynamic response =
        await TechnicianAppointmentsRepositoryImpl().getAppointments();
    if (response.length==0){
      emit(TechnicianAppointmentNoDataState());
    }
    else if (response[0].runtimeType != String) {
      emit(TechnicianAppointmentsInitState(customerCredential: response));
    } else {
      emit(TechnicianAppointmentsErrorActionState(error: response[0]));
    }
  }

  Future<FutureOr<void>> technicianAppointmentDeleteButtonClickedEvent(TechnicianAppointmentDeleteButtonClickedEvent event, Emitter<TechnicianAppointmentsState> emit) async {
    dynamic response= await TechnicianAppointmentDeleteRepositoryImpl().deleteAppointment(event.appointmentDelete);
    dynamic responseRef= await TechnicianAppointmentsRepositoryImpl().getAppointments();
    if (response=="Sucessfully Deleted"){
      emit(TechnicianAppointmentsSucssesfullyDeletedActionState(sucess: response));
      emit(TechnicianAppointmentsInitState(customerCredential: responseRef));
    }else{
      emit(TechnicianAppointmentsFailedToDeleteActionState(failure:response));
    }
  }
}
