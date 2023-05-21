import 'package:isar/isar.dart';

part 'workout.g.dart';

@Collection()
class Workout {
  Id id = Isar.autoIncrement;
  late DateTime _date;
  late int duration;

  Workout({required this.duration})
      : _date = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        );

  DateTime get date => _date;

  set date(DateTime newDate) {
    // You can add any additional validation or logic here
    _date = newDate;
  }
}


