import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/technician_account_information_credential_model.dart';
import '../repository/technician_account_information_credential_repository.dart';

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
    // print("buttonSelected state");
    isSelected[event.buttonName] = true;
    emit(TechnicianSelectionButtonClickedState(isClicked: isSelected));
  }

  FutureOr<void> technicianSelectionButtonUnclickedEvent(
      TechnicianSelectionButtonUnclickedEvent event,
      Emitter<TechnicianAccountInformationState> emit) {
    // print("buttonunselected state");
    isSelected[event.buttonName] = false;
    emit(TechnicianSelectionButtonUnclickedState(isClicked: isSelected));
  }

  FutureOr<void> technicianPhoneNumberInputEvent(TechnicianPhoneNumberInputEvent event, Emitter<TechnicianAccountInformationState> emit) {
    technicianCredential["phoneNumber"]=event.phoneNumber;
    emit(TechnicianSelectionButtonClickedState(isClicked: isSelected));//this is for maintaining the expertise buttons clicked 
                                                                        // after u clicked the summit button and get an error
  }

  FutureOr<void> technicianGarageNameInputEvent(TechnicianGarageNameInputEvent event, Emitter<TechnicianAccountInformationState> emit) {
    technicianCredential["gargeName"]=event.garageName;
    emit(TechnicianSelectionButtonClickedState(isClicked: isSelected));//this is for maintaining the expertise buttons clicked 
                                                                        // after u clicked the summit button and get an error
  }

  FutureOr<void> technicianGarageLocationInputEvent(TechnicianGarageLocationInputEvent event, Emitter<TechnicianAccountInformationState> emit) {
    // print(technicianCredential);
    technicianCredential["gargeLocation"]=event.garageLocation;
    emit(TechnicianSelectionButtonClickedState(isClicked: isSelected)); //this is for maintaining the expertise buttons clicked 
                                                                        // after u clicked the summit button and get an error
  }

  Future<FutureOr<void>> technicianAccountInformationSubmitButtonEvent(TechnicianAccountInformationSubmitButtonEvent event, Emitter<TechnicianAccountInformationState> emit) async {
    List<String> tempList=[];
    isSelected.forEach((key,value){
      if (value==true){
        tempList.add(key);
      }
      technicianCredential["expertise"]=tempList;
  });
    // print(technicianCredential);//email,technicianName,password are remaining.
    String response;
    if (technicianCredential["expertise"].isNotEmpty && technicianCredential['gargeLocation']!=""&& technicianCredential['gargeName']!=""&& technicianCredential['phoneNumber']!=""&& technicianCredential['phoneNumber']!=""){
      TechnicianAccountInformationCredential technicianInformationCredential=TechnicianAccountInformationCredential(expertises:technicianCredential['expertise']!,location:technicianCredential['gargeLocation']!,garage: technicianCredential['gargeName']!,phone: technicianCredential['phoneNumber']!);
      emit(TechnicianInputLoadingState());
    response=await TechnicianAccountInformationCredentialRepositoryImpl().updateInformation(technicianInformationCredential);
    }else if (technicianCredential["expertise"].isEmpty){
      response="Please Mention atleast one Expertise";
    }else{
      response='#';
    }
    
    if (response=="Successfully Recoreded!"){
      emit(TechnicianInputSucessActionState(sucess: response));
    }else if (response!="#"){
      emit(TechnicianInputFailureActionState(failure: response));
    }
  }
}
