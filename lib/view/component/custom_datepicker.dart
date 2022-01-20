import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  /// Create a CustomDatePicker.
  /// The Picker's date before selecting is [initialDate].
  /// After selecting the date, an action should be executed with [onSelected].
  /// The first and only arg is the selected date.
  ///
  /// Consider having a minimal function like the following :
  ///
  /// ```
  /// _updateOnSelectDate(DateTime date){
  ///   setState(() {
  ///     selectedDate = date;
  ///   });
  /// }
  /// ```
  ///
  const CustomDatePicker({Key? key, required this.initialDate, required this.onSelected}) : super(key: key);
  final DateTime initialDate;
  final Function onSelected;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        _selectDate(context);
      },
      child: Icon(Icons.calendar_today),
    );
  }

  /// Display a DatePicker and execute an action when date is selected.
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
    );
    if (selected != null && selected != initialDate) {
      onSelected(selected);
    }
  }
}
