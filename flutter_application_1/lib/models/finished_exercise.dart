import 'package:isar/isar.dart';

part 'finished_exercise.g.dart';

@Collection()
class FinishedExercise {
  Id id = Isar.autoIncrement;
  late int sets;
  late int reps;
  late int resistance;
  late DateTime date;
  late int exerciseId;
  late int workoutId;

  FinishedExercise(
      {required this.sets,
      required this.reps,
      required this.resistance,
      required this.exerciseId,
      required this.workoutId})
      : date = DateTime.now();
}
