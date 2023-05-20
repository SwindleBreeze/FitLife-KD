import 'package:isar/isar.dart';

part 'water_intake.g.dart';

@Collection()
class WaterIntake {

  Id id = Isar.autoIncrement;
  late DateTime date;
  double waterIntake;
  double maxWaterIntake;

  WaterIntake({
    required DateTime date,
    required this.waterIntake,
    required this.maxWaterIntake,
  }) : date = DateTime.utc(date.year, date.month,
            date.day); // Store only the date part as DateTime in UTC

  // Getter for formatted date (without time)
  // DateTime get date => DateTime(_date.year, _date.month, _date.day);
}


