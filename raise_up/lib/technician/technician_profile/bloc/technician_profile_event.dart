part of 'technician_profile_bloc.dart';

@immutable
abstract class TechnicianProfileEvent {}

class TechnicianHistoryInitialEvent extends TechnicianProfileEvent {}

class TechnicianProfileHomeButtonClickedEvent extends TechnicianProfileEvent {}

class TechnicianProfileTodoButtonClickedEvent extends TechnicianProfileEvent {}
