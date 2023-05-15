import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:flutter_application_1/models/group.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/water_intake.dart';
import 'package:flutter_application_1/models/sleep_cycle.dart';
import 'package:flutter_application_1/models/workout.dart';
import 'package:flutter_application_1/models/finished_exercise.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// user.dart not yet implemented
// to build all isar and models use "flutter pub run build_runner build --delete-conflicting-outputs" in terminal
import 'package:path_provider/path_provider.dart';

class IsarService {
  static final IsarService _singleton = IsarService._internal();

  //Makes it so you can use a single IsarService in all dart files
  factory IsarService() {
    return _singleton;
  }

  late Future<Isar> _isar;

  IsarService._internal() {
    _isar = openDB();
  }

  static IsarService get instance => _singleton;

// Open the database and create it if it doesn't exist
  Future<Isar> openDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/isar-db';

    final dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    print(path);
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([
        ExerciseSchema,
        GroupSchema,
        WaterIntakeSchema,
        WorkoutSchema,
        FinishedExerciseSchema,
        SleepCycleSchema,
      ], inspector: true, directory: path);
    }

    return Future.value(Isar.getInstance());
  }

  /// Insert default data if the database is empty
  Future<Isar> insertIfEmpty() async {
    final isar = await _isar;

    if (await isar.groups.count() != 0) {
      return Future.value(Isar.getInstance());
    }

    await isar.writeTxn(() async {
      final pull = Group()..name = "Pull";
      final push = Group()..name = "Push";
      final legs = Group()..name = "Legs";

      // Add groups to the database
      await isar.groups.putAll([pull, push, legs]);

      final pullExercises =
          await fetchExercises(8); // fetch for pull exercises (id = 8)
      final pushExercises =
          await fetchExercises(12); // fetch for push exercises (id = 12)
      final legsExercises =
          await fetchExercises(9); // fetch for legs exercises (id = 9)

      // Add exercises to groups and links to exercises
      for (var ex in pullExercises) {
        final exercise = Exercise()
          ..name = ex['name']
          ..description = ex['description'];
        exercise.groupid = pull.id;
        await isar.exercises.put(exercise);
      }

      for (var ex in pushExercises) {
        final exercise = Exercise()
          ..name = ex['name']
          ..description = ex['description'];
        exercise.groupid = push.id;
        await isar.exercises.put(exercise);
      }

      for (var ex in legsExercises) {
        final exercise = Exercise()
          ..name = ex['name']
          ..description = ex['description'];
        exercise.groupid = legs.id;
        await isar.exercises.put(exercise);
      }
    });

    return Future.value(Isar.getInstance());
  }

  Future<List<dynamic>> fetchExercises(int category) async {
    final response = await http.get(Uri.parse(
        'https://wger.de/api/v2/exercise/?language=2&category=${category}'));
    final exercises = jsonDecode(response.body)['results'];
    return exercises.take(10).toList();
  }

  // Insert exercise (expected Exercise object)
// Insert exercise (expected Exercise object)
  Future<void> addExercise(Exercise exercise) async {
    final isar = await _isar;
    await isar.writeTxn<Exercise>(() {
      isar.exercises.put(exercise);
      return Future.value(exercise);
    });
  }

  // Insert group (expected Group object)
  Future<void> addGroup(Group group) async {
    final isar = await _isar;
    isar.writeTxn<Group>(() {
      isar.groups.put(group);
      return Future.value(group.id as FutureOr<Group>?);
    });
  }

  // Get all Groups
  Future<List<Group>> getGroups() async {
    final isar = await _isar;
    return isar.groups.where().findAll();
  }

  // Get all Exercises
  Future<List<Exercise>> getExercises() async {
    final isar = await _isar;
    return isar.exercises.where().findAll();
  }

  // Watch groups for changes
  Stream<List<Group>> watchGroups() async* {
    final isar = await _isar;
    yield* isar.groups.where().watch(fireImmediately: true);
  }

  // Watch exercises for changes
  Stream<List<Exercise>> watchExercises() async* {
    final isar = await _isar;
    yield* isar.exercises.where().watch(fireImmediately: true);
  }

// Insert a new WaterIntake
  Future<void> addWaterIntake(WaterIntake waterIntake) async {
    final isar = await _isar;
    await isar.writeTxn(() {
      isar.waterIntakes.put(waterIntake);
      return Future.value();
    });
  }

// Get water intake by date
  Future<WaterIntake?> getWaterIntakeByDate(DateTime date) async {
    final isar = await _isar;
    return isar.waterIntakes.where().filter().dateEqualTo(date).findFirst();
  }

  // Update a WaterIntake
  Future<void> updateWaterIntake(WaterIntake waterIntake) async {
    final isar = await _isar;
    await isar.writeTxn<void>(() {
      isar.waterIntakes.put(waterIntake);
      return Future.value();
    });
  }

  // Get all WaterIntakes
  Future<List<WaterIntake>> getWaterIntakes() async {
    final isar = await _isar;
    return isar.waterIntakes.where().findAll();
  }

  // Watch WaterIntakes for changes
  Stream<List<WaterIntake>> watchWaterIntakes() async* {
    final isar = await _isar;
    yield* isar.waterIntakes.where().watch(fireImmediately: true);
  }

  // Delete all data
  Future<void> dropDB() async {
    final isar = await _isar;
    await isar.writeTxn(() => isar.clear());
  }

  // Get all exercises by group
  Future<List<Exercise>> getExercisesByGroup(Group group) async {
    final isar = await _isar;
    return isar.exercises
        .where()
        .filter()
        .group((q) => q.idEqualTo(group.id))
        .findAll();
  }

  // Get all SleepCycles
  Future<List<SleepCycle>> getAllSleepCycles() async {
    final isar = await _isar;
    return isar.sleepCycles.where().findAll();
  }

  // Get a SleepCycle by ID
  Future<SleepCycle?> getSleepCycleById(int id) async {
    final isar = await _isar;
    return isar.sleepCycles.get(id);
  }

  // Add a new SleepCycle
  Future<void> addSleepCycle(SleepCycle sleepCycle) async {
    final isar = await _isar;
    await isar.writeTxn(() {
      return isar.sleepCycles.put(sleepCycle);
    });
  }

  // Update a SleepCycle
  Future<void> updateSleepCycle(SleepCycle sleepCycle) async {
    final isar = await _isar;
    await isar.writeTxn(() {
      return isar.sleepCycles.put(sleepCycle);
    });
  }

  // Get a SleepCycle by date
  Future<SleepCycle?> getSleepCycleByDate(DateTime date) async {
    final isar = await _isar;
    return isar.sleepCycles.where().filter().dateEqualTo(date).findFirst();
  }

  Future<List<SleepCycle>> getSleepCyclesBetweenDates(
      DateTime startDate, DateTime endDate) async {
    final isar = await _isar;

    final startDateTime =
        DateTime(startDate.year, startDate.month, startDate.day);
    final endDateTime = DateTime(endDate.year, endDate.month, endDate.day);

    final sleepCycles = await isar.sleepCycles
        .where()
        .filter()
        .dateBetween(startDateTime, endDateTime)
        .findAll();
    return sleepCycles;
  }

  // add Workouts
  Future<void> addWorkout(Workout workout) async {
    final isar = await _isar;
    print(workout);
    await isar.writeTxn(() {
      return isar.workouts.put(workout);
    });
  }

  // Get all Workouts
  Future<List<Workout>> getWorkouts() async {
    final isar = await _isar;
    return isar.workouts.where().findAll();
  }

  // Insert FinishedExercise
  Future<void> addFinishedExercise(FinishedExercise finishedExercise) async {
    final isar = await _isar;
    await isar.writeTxn(() {
      return isar.finishedExercises.put(finishedExercise);
    });
  }

  // Get all FinishedExercises
  Future<List<FinishedExercise>> getFinishedExercises() async {
    final isar = await _isar;
    return isar.finishedExercises.where().findAll();
  }

  // Update duration of last workout
  Future<void> updateLastWorkoutDuration(int duration) async {
    final isar = await _isar;
    final lastWorkout = await isar.workouts.where().findAll();
    lastWorkout.last.duration = duration;
    await isar.writeTxn(() {
      return isar.workouts.put(lastWorkout.last);
    });
  }

  // get last workout
  Future<Workout?> getLastWorkout() async {
    final isar = await _isar;
    final lastWorkout = await isar.workouts.where().findAll();
    return lastWorkout.last;
  }
}
