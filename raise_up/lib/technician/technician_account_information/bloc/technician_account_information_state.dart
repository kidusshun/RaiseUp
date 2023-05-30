part of 'technician_account_information_bloc.dart';

@immutable
abstract class TechnicianAccountInformationState {}

abstract class TechnicianAccountInformationActionState
    extends TechnicianAccountInformationState {}

class TechnicianInitialState extends TechnicianAccountInformationState {}

class TechnicianAccountInformationInitial
    extends TechnicianAccountInformationState {}

class TechnicianSelectionButtonClickedState
    extends TechnicianAccountInformationActionState {
  Map<String, bool> isClicked;

  TechnicianSelectionButtonClickedState({required this.isClicked});
}

class TechnicianSelectionButtonUnclickedState
    extends TechnicianAccountInformationActionState {
  Map<String, bool> isClicked;
  TechnicianSelectionButtonUnclickedState({required this.isClicked});
}

class TechnicianInputSucessState extends TechnicianAccountInformationActionState{}

class TechnicianInputProgress extends TechnicianAccountInformationActionState{}