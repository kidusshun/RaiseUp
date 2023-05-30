part of 'technician_account_information_bloc.dart';

@immutable
abstract class TechnicianAccountInformationEvent {}

class TechnicianInitialEvent extends TechnicianAccountInformationEvent {}

class TechnicianSelectionButtonClickedEvent
    extends TechnicianAccountInformationEvent {
  String buttonName;
  TechnicianSelectionButtonClickedEvent({required this.buttonName});
}

class TechnicianSelectionButtonUnclickedEvent
    extends TechnicianAccountInformationEvent {
  String buttonName;
  TechnicianSelectionButtonUnclickedEvent({required this.buttonName});
}

class TechnicianPhoneNumberInputEvent extends TechnicianAccountInformationEvent{
  String phoneNumber;
  TechnicianPhoneNumberInputEvent({required this.phoneNumber});
}

class TechnicianGarageNameInputEvent extends TechnicianAccountInformationEvent{
  String garageName;
  TechnicianGarageNameInputEvent({required this.garageName});
}

class TechnicianGarageLocationInputEvent extends TechnicianAccountInformationEvent{
  String garageLocation;
  TechnicianGarageLocationInputEvent({required this.garageLocation});
}

class TechnicianAccountInformationSubmitButtonEvent extends TechnicianAccountInformationEvent{}

