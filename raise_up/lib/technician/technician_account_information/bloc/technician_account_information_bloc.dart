import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'technician_account_information_event.dart';
part 'technician_account_information_state.dart';

class TechnicianAccountInformationBloc extends Bloc<
    TechnicianAccountInformationEvent, TechnicianAccountInformationState> {
  List<String> expertise = [
    "Body Work",
    "Exahust",
    "Electrical System",
    "Transmission",
    "Engine",
    "Sterring",
    "Tire & Axis",
    "Suspenssion & Sterring",
    "Break"
  ];
  Map<String, bool> isSelected = {
    "Body Work": false,
    "Exahust": false,
    "Electrical System": false,
    "Transmission": false,
    "Engine": false,
    "Sterring": false,
    "Tire & Axis": false,
    "Suspenssion & Sterring": false,
    "Break": false
  };

  Map<String,dynamic> technicianCredential={};
  TechnicianAccountInformationBloc()
      : super(TechnicianAccountInformationInitial()) {
    // on<TechnicianAccountInformationEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<TechnicianInitialEvent>(technicianInitialEvent);
    on<TechnicianSelectionButtonClickedEvent>(
        technicianSelectionButtonClickedEvent);
    on<TechnicianSelectionButtonUnclickedEvent>(
        technicianSelectionButtonUnclickedEvent);
    on<TechnicianPhoneNumberInputEvent>(technicianPhoneNumberInputEvent);
    on<TechnicianGarageNameInputEvent>(technicianGarageNameInputEvent);
    on<TechnicianGarageLocationInputEvent>(technicianGarageLocationInputEvent);
    on<TechnicianAccountInformationSubmitButtonEvent>(technicianAccountInformationSubmitButtonEvent);
  }
  FutureOr<void> technicianInitialEvent(TechnicianInitialEvent event,
      Emitter<TechnicianAccountInformationState> emit) {}

  FutureOr<void> technicianSelectionButtonClickedEvent(
      TechnicianSelectionButtonClickedEvent event,
      Emitter<TechnicianAccountInformationState> emit) {
    print("buttonSelected state");
    isSelected[event.buttonName] = true;
    emit(TechnicianSelectionButtonClickedState(isClicked: isSelected));
  }

  FutureOr<void> technicianSelectionButtonUnclickedEvent(
      TechnicianSelectionButtonUnclickedEvent event,
      Emitter<TechnicianAccountInformationState> emit) {
    print("buttonunselected state");
    isSelected[event.buttonName] = false;
    emit(TechnicianSelectionButtonUnclickedState(isClicked: isSelected));
  }

  FutureOr<void> technicianPhoneNumberInputEvent(TechnicianPhoneNumberInputEvent event, Emitter<TechnicianAccountInformationState> emit) {
    technicianCredential["phoneNumber"]=event.phoneNumber;
  }

  FutureOr<void> technicianGarageNameInputEvent(TechnicianGarageNameInputEvent event, Emitter<TechnicianAccountInformationState> emit) {
    technicianCredential["gargeName"]=event.garageName;
  }

  FutureOr<void> technicianGarageLocationInputEvent(TechnicianGarageLocationInputEvent event, Emitter<TechnicianAccountInformationState> emit) {
    // print(technicianCredential);
    technicianCredential["gargeLocation"]=event.garageLocation;
  }

  FutureOr<void> technicianAccountInformationSubmitButtonEvent(TechnicianAccountInformationSubmitButtonEvent event, Emitter<TechnicianAccountInformationState> emit) {
    List<String> tempList=[];
    isSelected.forEach((key,value){
      if (value==true){
        tempList.add(key);
      }
      technicianCredential["expertise"]=tempList;
  });
    print(technicianCredential);//email,technicianName,password are remaining.
    // Now we create http request and save technicianCredential on database.
    emit(TechnicianInputSucessState());
  }
}
