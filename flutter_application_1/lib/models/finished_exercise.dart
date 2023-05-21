import 'package:isar/isar.dart';

part 'finished_exercise.g.dart';

@Collection()
class FinishedExercise {
  Id id = Isar.autoIncrement;
  late int sets;
  late int reps;
  late int resistance;
  late DateTime _date;
  late int exerciseId;
  late int workoutId;
  String exerciseName = "";
  DateTime ?tmpDate;

  FinishedExercise(
      {required this.sets,
      required this.reps,
      required this.resistance,
      required this.exerciseId,
      required this.workoutId, this.tmpDate})
      : _date = DateTime.now();

  DateTime get date => _date;

  set date(DateTime newDate) {
    // You can add any additional validation or logic here
    _date = newDate;
  }
}
