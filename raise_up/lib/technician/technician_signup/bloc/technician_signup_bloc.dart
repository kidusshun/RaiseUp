import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'technician_signup_event.dart';
part 'technician_signup_state.dart';

class TechnicianSignupBloc extends Bloc<TechnicianSignupEvent, TechnicianSignupState> {
  TechnicianSignupBloc() : super(TechnicianSignupInitial()) {
    on<TechnicianSignupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
