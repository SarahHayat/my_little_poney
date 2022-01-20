import 'package:flutter/material.dart';
import 'package:my_little_poney/helper/int_extension.dart';

extension DateTimeExtension on DateTime{
  /// Returns day's name
  String getWeekDayName() {
    switch (this.weekday) {
      case 1:
        return "monday";
      case 2:
        return "tuesday";
      case 3:
        return "wednesday";
      case 4:
        return "thursday";
      case 5:
        return "friday";
      case 6:
        return "saturday";
      case 7:
        return "sunday";
      default:
        return "monday";
    }
  }

  /// Returns a color for week
  Color getWeekDayColor() {
    switch (this.weekday) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.lightGreenAccent;
      case 5:
        return Colors.green;
      case 6:
        return Colors.greenAccent;
      case 7:
        return Colors.lightBlueAccent;
      default:
        return Colors.red;
    }
  }

  /// Returns month's name
  String getMonthName() {
    switch (this.month) {
      case 1:
        return "january";
      case 2:
        return "february";
      case 3:
        return "march";
      case 4:
        return "april";
      case 5:
        return "may";
      case 6:
        return "june";
      case 7:
        return "july";
      case 8:
        return "august";
      case 9:
        return "september";
      case 10:
        return "october";
      case 11:
        return "november";
      case 12:
        return "december";
      default:
        return "january";
    }
  }

  /// Returns monday date for this date.
  ///
  ///  by default, will return the date without hour
  DateTime getWeekFirstDay({removeTime:true}){
    if(this.weekday == DateTime.monday){
      DateTime date = this;
    }
    DateTime date = this.add(Duration( days: -this.weekday+1));

    if(removeTime){
      return date.getOnlyDate();
    }
    return date;
  }

  /// Returns 'true' if this date and [comparedDate] are in the same week.
  bool areDateSameWeek(DateTime comparedDate){
    return this.getWeekFirstDay().getOnlyDate() == comparedDate.getWeekFirstDay().getOnlyDate();
  }

  /// Returns only the date of the DateTime
  DateTime getOnlyDate(){
    return DateUtils.dateOnly(this);
  }

  /// Returns date only with 'd/m/Y' format
  String getFrenchDate(){
    return "${this.day.left0()}/${this.month.left0()}/${this.year}";
  }

  /// Returns date and time with 'd/m/Y H:i' format
  String getFrenchDateTime(){
    return  "${getFrenchDate()} ${this.hour.left0()}:${this.minute.left0()}";
  }
}