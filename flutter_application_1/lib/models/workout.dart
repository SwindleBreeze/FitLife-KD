import 'package:isar/isar.dart';

part 'workout.g.dart';

@Collection()
class Workout {
  Id id = Isar.autoIncrement;
  late DateTime date;
  late int duration;
  Workout({required this.duration}) : date = DateTime.now();
}
