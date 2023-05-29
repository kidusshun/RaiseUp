import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raise_up/widgets/selectionButton.dart';

import '../technician/technician_account_information/bloc/technician_account_information_bloc.dart';

class GestureButton extends StatelessWidget {
  String name;
  GestureButton({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TechnicianAccountInformationBloc,
        TechnicianAccountInformationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is TechnicianSelectionButtonClickedState){
          if (state.isClicked[name]==true){
            state=TechnicianSelectionButtonClickedState(isClicked: state.isClicked);
          }else if(state.isClicked[name]==false){
            state=TechnicianSelectionButtonUnclickedState(isClicked: state.isClicked);
          }
        }else if (state is TechnicianSelectionButtonUnclickedState){
          if (state.isClicked[name]==true){
            state=TechnicianSelectionButtonClickedState(isClicked: state.isClicked);
          }else if(state.isClicked[name]==false){
            state=TechnicianSelectionButtonUnclickedState(isClicked: state.isClicked);
          }
        }
        
        if (state is TechnicianSelectionButtonClickedState) {
          return GestureDetector(
            onTap: () {
              context.read<TechnicianAccountInformationBloc>().add(
                  TechnicianSelectionButtonUnclickedEvent(
                      buttonName: name));
            },
            child: SelectionButton(
                    text: name, selected: state.isClicked[name])
                .selectionButton,
          );
          // return gestureButton.button(bloc:TechnicianAccountInformationBloc(),event:TechnicianSelectionButtonUnclickedEvent(buttonName: "Body Work"),isClicked:state.isClicked,name:"Body Work");
        } else if (state is TechnicianSelectionButtonUnclickedState) {
          return GestureDetector(
            onTap: () {
              context.read<TechnicianAccountInformationBloc>().add(
                  TechnicianSelectionButtonClickedEvent(
                      buttonName: name));
            },
            child: SelectionButton(
                    text: name, selected: state.isClicked[name])
                .selectionButton,
          );
          // return gestureButton.button(bloc:TechnicianAccountInformationBloc(),event:TechnicianSelectionButtonClickedEvent(buttonName: "Body Work"),isClicked:state.isClicked,name:"Body Work");
        } else {
          return GestureDetector(
            onTap: () {
              context.read<TechnicianAccountInformationBloc>().add(
                  TechnicianSelectionButtonClickedEvent(
                      buttonName: name));
            },
            child: SelectionButton(text: name, selected: false)
                .selectionButton,
          );
          // return gestureButton.button(bloc:TechnicianAccountInformationBloc(),event:TechnicianSelectionButtonClickedEvent(buttonName: "Body Work"),isClicked:true,name:"Body Work");
        }
      },
    );
  }
}
