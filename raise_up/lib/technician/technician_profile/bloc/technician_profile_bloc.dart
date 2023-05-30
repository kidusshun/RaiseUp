import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:raise_up/technician/technician_profile/model/technician_profile_class.dart';
import 'package:raise_up/technician/technician_profile/repos/technician_profile_repository.dart';
part 'technician_profile_event.dart';
part 'technician_profile_state.dart';

class TechnicianProfileBloc
    extends Bloc<TechnicianProfileEvent, TechnicianProfileState> {
  TechnicianProfileBloc() : super(TechnicianProfileInitial());

  @override
  Stream<TechnicianProfileState> mapEventToState(
    TechnicianProfileEvent event,
  ) async* {
    if (event is TechnicianProfileLoadDataEvent) {
      yield* _mapTechnicianProfileLoadDataEventToState();
    } else if (event is TechnicianProfileEditNameButtonClickedEvent) {
      yield* _mapTechnicianProfileEditNameButtonClickedEventToState();
    } else if (event is TechnicianProfileHomeButtonClickedEvent) {
      yield* _mapTechnicianProfileHomeButtonClickedEventToState();
    } else if (event is TechnicianProfileTodoButtonClickedEvent) {
      yield* _mapTechnicianProfileTodoButtonClickedEventToState();
    } else if (event is TechnicianProfileDeleteHistoryButtonClickedEvent) {
      yield* _mapTechnicianProfileDeleteHistoryButtonClickedEventToState();
    } else if (event is TechnicianProfileEditExpertiseButtonClickedEvent) {
      yield* _mapTechnicianProfileEditExpertiseButtonClickedEventToState();
    }
  }

  Stream<TechnicianProfileState>
      _mapTechnicianProfileLoadDataEventToState() async* {
    try {
      // Create an instance of the TechnicianProfileRepo
      final technicianProfileRepo = TechnicianProfileRepo();

      // Fetch the technician profiles from the repository
      final technicianProfiles = await technicianProfileRepo.getUsers();

      // Assuming you want to use the first profile from the list
      final technicianProfile =
          technicianProfiles.isNotEmpty ? technicianProfiles[0] : null;

      if (technicianProfile != null) {
        yield TechnicianProfileLoadedSuccessState(technicianProfile);
      } else {
        yield TechnicianProfileErrorState();
      }
    } catch (error) {
      yield TechnicianProfileErrorState();
    }
  }

  Stream<TechnicianProfileState>
      _mapTechnicianProfileEditNameButtonClickedEventToState() async* {
    yield TechnicianprofileEditedNameState();
  }

  Stream<TechnicianProfileState>
      _mapTechnicianProfileHomeButtonClickedEventToState() async* {
    yield TechnicianProfileNavigateToHomeState();
  }

  Stream<TechnicianProfileState>
      _mapTechnicianProfileTodoButtonClickedEventToState() async* {
    yield TechnicianProfileNavigateToTodoState();
  }

  Stream<TechnicianProfileState>
      _mapTechnicianProfileDeleteHistoryButtonClickedEventToState() async* {
    // Implement delete history functionality here
  }

  Stream<TechnicianProfileState>
      _mapTechnicianProfileEditExpertiseButtonClickedEventToState() async* {
    yield TechnicianprofileEditedExpertiseState();
  }
}
