import 'package:isar/isar.dart';

part 'sleep_cycle.g.dart';

@Collection()
class SleepCycle {

  Id id = Isar.autoIncrement;
  late DateTime _date; // Private DateTime property
  DateTime bedTime;
  DateTime wakeUpTime;
  int sleepTime;
  

  SleepCycle({
    required DateTime date,
    required this.bedTime,
    required this.wakeUpTime,
    required this.sleepTime,
  }) : _date = DateTime.utc(date.year, date.month,
            date.day); // Store only the date part as DateTime in UTC

  // Getter for formatted date (without time)
  DateTime get date => DateTime(_date.year, _date.month, _date.day);
}
