import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/technicianProfileNameModel.dart';
import '../model/technician_profile_class.dart';
import '../model/technician_profile_history.dart';
import '../repository/technician_profile_repository.dart';

part 'technician_profile_event.dart';
part 'technician_profile_state.dart';

class TechnicianProfileBloc
    extends Bloc<TechnicianProfileEvent, TechnicianProfileState> {
  TechnicianProfileBloc() : super(TechnicianProfileInitial()) {
    on<TechnicianProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<TechnicianHistoryInitialEvent>(technicianHistoryInitialEvent);
    on<TechnicianHistoryInitialNameEvent>(technicianHistoryInitialNameEvent);
  }

  Future<FutureOr<void>> technicianHistoryInitialEvent(
      TechnicianHistoryInitialEvent event,
      Emitter<TechnicianProfileState> emit) async {
    dynamic response = await TechnicianProfileRepositoryImpl().getHistory();
    // print(response);
    if (response.length==0){
      emit(TechnicianProfileNoHistoryState());
    }
    else if (response[0].runtimeType != String) {
      emit(TechnicianProfileInitialState(history: response));
    } else {
      emit(TechnicianProfileFailedToLoadHistoryActionState(failure: response[0]));
    }
  }

  Future<FutureOr<void>> technicianHistoryInitialNameEvent(TechnicianHistoryInitialNameEvent event, Emitter<TechnicianProfileState> emit) async {
    dynamic responseName=await TechnicianProfileRepositoryImpl().getTechnicianName();
    emit(TechnicianProfileNameLoadedState(profileName: responseName));
  }
}
