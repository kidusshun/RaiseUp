import 'package:flutter/material.dart';

class TimeSelection {

  TimeOfDay selectedTime = TimeOfDay.now();

  int get hour => selectedTime.hour;

  int get minute => selectedTime.minute;
  

  dynamic selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      cancelText: 'Not now',
      confirmText: 'Set time',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime)
        selectedTime = picked;
        return selectedTime;
  }
}