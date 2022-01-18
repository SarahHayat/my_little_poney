import 'package:my_little_poney/models/Contest.dart';
import 'package:my_little_poney/models/Lesson.dart';

import 'Party.dart';

class Event {
  List<Party> parties;
  List<Lesson> lessons;
  List<Contest> contests;

  Event(this.parties, this.lessons, this.contests);
}
