import 'package:flutter/material.dart';

class DateSelection{
  DateTime _selectedDate = DateTime.now().add(Duration(days: 1));

  dynamic selectDate(BuildContext context) async {
    bool _isSelectable(DateTime day) {
      DateTime today = DateTime.now();
      return day.isAfter(today);
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      helpText: 'Select booking date', // Can be used as title
      cancelText: 'Not now',
      confirmText: 'Book',
      fieldLabelText: 'Enter date',
      fieldHintText: 'Month/Date/Year',
      selectableDayPredicate: _isSelectable,
    );
    if (picked != null && picked != _selectedDate) {
        // Update the selected date when the user confirms the dialog
      _selectedDate = picked;
      return _selectedDate;
    }
  }
}