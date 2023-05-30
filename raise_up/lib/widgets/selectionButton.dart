import "package:flutter/material.dart";

class SelectionButton {
  late Color backgroundColor;
  late String text;
  late Color borderColor;
  bool? selected;
  bool? get getSelected => selected;
  void colorPicker() {
    if (getSelected == false) {
      backgroundColor = Color.fromARGB(237, 217, 217, 217);
      borderColor = Colors.transparent;
    } else {
      backgroundColor = Color.fromARGB(246, 176, 242, 247);
      borderColor = Color.fromARGB(199, 20, 158, 189);
    }
  }

  SelectionButton({required this.text, this.selected}) {
    this.colorPicker();
  }
  Widget get selectionButton => FittedBox(
        child: Container(
          margin:EdgeInsets.symmetric(vertical:8,horizontal: 0),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          constraints: BoxConstraints(
            minWidth: 0, 
            minHeight: 0, 
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          // width: 85,
          // height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: borderColor,
              width: 3.0,
            ),
            color: backgroundColor,
          ),
        ),
      );
}
