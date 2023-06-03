import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
    on<TechnicianProfileHomeButtonClickedEvent>(
        technicianProfileHomeButtonClickedEvent);
    on<TechnicianProfileTodoButtonClickedEvent>(
        technicianProfileTodoButtonClickedEvent);
  }

  Future<FutureOr<void>> technicianHistoryInitialEvent(
      TechnicianHistoryInitialEvent event,
      Emitter<TechnicianProfileState> emit) async {
    void response = await TechnicianProfileRepositoryImpl().getHistory();
    // print(response);
  }

  FutureOr<void> technicianProfileHomeButtonClickedEvent(
      TechnicianProfileHomeButtonClickedEvent event,
      Emitter<TechnicianProfileState> emit) {
    emit(TechnicianProfileNavigateToHomeState());
  }

  FutureOr<void> technicianProfileTodoButtonClickedEvent(
      TechnicianProfileTodoButtonClickedEvent event,
      Emitter<TechnicianProfileState> emit) {
    emit(TechnicianProfileNavigateToTodoState());
  }
}
