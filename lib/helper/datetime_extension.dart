import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime{
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

  DateTime getOnlyDate(){
    return DateUtils.dateOnly(this);
  }

  String getFrenchDate(){
    return "${this.day}/${this.month}/${this.year}";
  }

}