import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  late Color backgroundColor;
  late String text;
  late Color borderColor;
  bool isSelected;
  late Function(bool) onSelected;

  SelectionButton({
    required this.text,
    this.isSelected = false,
    void Function(bool)? onSelected,
  }) {
    colorPicker();
    this.onSelected = onSelected ?? (bool value) {};
  }

  void colorPicker() {
    if (isSelected) {
      backgroundColor = Color.fromARGB(246, 176, 242, 247);
      borderColor = Color.fromARGB(199, 20, 158, 189);
    } else {
      backgroundColor = Color.fromARGB(237, 217, 217, 217);
      borderColor = Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          isSelected = !isSelected;
          colorPicker();
          onSelected(isSelected);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          constraints: BoxConstraints(
            minWidth: 0, // Minimum width
            minHeight: 0, // Minimum height
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: borderColor,
              width: 3.0,
            ),
            color: backgroundColor,
          ),
        ),
      ),
    );
  }
}
