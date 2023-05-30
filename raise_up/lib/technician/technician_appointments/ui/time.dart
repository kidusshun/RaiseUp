import 'package:flutter/material.dart';

class TimePickerDemo extends StatefulWidget {
  @override
  _TimePickerDemoState createState() => _TimePickerDemoState();
}

class _TimePickerDemoState extends State<TimePickerDemo> {
  // Variable to store the selected time
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Function to display the time picker dialog and update the time
  void _selectTime(BuildContext context) async {
    // Call showTimePicker function to show the time picker dialog
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      cancelText: 'Not now',
      confirmText: 'Set time',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        // Update the selected time when the user confirms the dialog
        _selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Time Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              // Display the selected time
              _selectedTime.format(context),
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            // Button to call the time picker dialog
            ElevatedButton(
              onPressed: () => _selectTime(context), // Refer step 3
              child: Text(
                'Select time',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
