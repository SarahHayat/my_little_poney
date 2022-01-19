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

  DateTime getWeekFirstDay(){
    if(this.weekday == DateTime.monday){
      return this;
    }
    return this.add(Duration( days: -this.weekday+1));
  }

  String getFrenchDate(){
    return "${this.day}/${this.month}/${this.year}";
  }
}