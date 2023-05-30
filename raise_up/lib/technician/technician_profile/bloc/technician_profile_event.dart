part of 'technician_profile_bloc.dart';

@immutable
abstract class TechnicianProfileEvent {}

class TechnicianProfileLoadDataEvent extends TechnicianProfileEvent {}

class TechnicianProfileEditNameButtonClickedEvent
    extends TechnicianProfileEvent {}

class TechnicianProfileEditExpertiseButtonClickedEvent
    extends TechnicianProfileEvent {}

class TechnicianProfileDeleteHistoryButtonClickedEvent
    extends TechnicianProfileEvent {}

class TechnicianProfileHomeButtonClickedEvent extends TechnicianProfileEvent {}

class TechnicianProfileTodoButtonClickedEvent extends TechnicianProfileEvent {}
