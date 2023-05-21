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

import '../models/user.dart';

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
        UserSchema
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

    await dropDB();

    List<Map<String, dynamic>> workoutData = [
      {"date": 1684015200000000, "duration": 59477, "id": 1},
      {"date": 1684274400000000, "duration": 19857, "id": 2},
      {"date": 1684360800000000, "duration": 5000, "id": 43959747},
      {"date": 1684447200000000, "duration": 32325, "id": 43959748},
      {"date": 1684533600000000, "duration": 70404, "id": 43959749},
      {"date": 1684620000000000, "duration": 58151, "id": 43959750}
    ];

    List<Workout> preparedWorkouts = workoutData.map((workout) {
      int dateInMicroseconds =
          workout['date']; // Convert milliseconds to microseconds
      DateTime dateTime =
          DateTime.fromMicrosecondsSinceEpoch(dateInMicroseconds);

      Workout v = Workout(
        duration: workout['duration'],
      );

      v.date = dateTime;

      return v;
    }).toList();

    List<FinishedExercise> finishedExercises = [
      FinishedExercise(
        tmpDate: DateTime.fromMicrosecondsSinceEpoch(1684271137988356),
        exerciseId: 41,
        reps: 5,
        resistance: 20,
        sets: 8,
        workoutId: 1,
      ),
      FinishedExercise(
        tmpDate: DateTime.fromMicrosecondsSinceEpoch(1684271146531771),
        exerciseId: 42,
        reps: 1,
        resistance: 1,
        sets: 1,
        workoutId: 1,
      ),
      FinishedExercise(
        tmpDate: DateTime.fromMicrosecondsSinceEpoch(1684271155368883),
        exerciseId: 43,
        reps: 1,
        resistance: 1,
        sets: 1,
        workoutId: 1,
      ),
      FinishedExercise(
        tmpDate: DateTime.fromMicrosecondsSinceEpoch(1684271163660255),
        exerciseId: 44,
        reps: 10,
        resistance: 10,
        sets: 10,
        workoutId: 1,
      ),
      FinishedExercise(
        tmpDate: DateTime.fromMicrosecondsSinceEpoch(1684358165171668),
        exerciseId: 21,
        reps: 1,
        resistance: 1,
        sets: 1,
        workoutId: 2,
      ),
      FinishedExercise(
        tmpDate: DateTime.fromMicrosecondsSinceEpoch(1684511825012956),
        exerciseId: 21,
        reps: 1,
        resistance: 1,
        sets: 1,
        workoutId: 3,
      ),
      FinishedExercise(
        tmpDate: DateTime.fromMicrosecondsSinceEpoch(1684511837329252),
        exerciseId: 22,
        reps: 5,
        resistance: 20,
        sets: 4,
        workoutId: 3,
      ),
      FinishedExercise(
        tmpDate: DateTime.fromMicrosecondsSinceEpoch(1684598932705061),
        exerciseId: 11,
        reps: 0,
        resistance: 0,
        sets: 0,
        workoutId: 4,
      ),
      FinishedExercise(
        tmpDate: DateTime.fromMicrosecondsSinceEpoch(1684660738679296),
        exerciseId: 1,
        reps: 1,
        resistance: 3,
        sets: 2,
        workoutId: 5,
      ),
      FinishedExercise(
        tmpDate: DateTime.fromMicrosecondsSinceEpoch(1684660751786216),
        exerciseId: 2,
        reps: 4,
        resistance: 60,
        sets: 8,
        workoutId: 5,
      ),
      FinishedExercise(
        tmpDate: DateTime.fromMicrosecondsSinceEpoch(1684660761671068),
        exerciseId: 3,
        reps: 3,
        resistance: 100,
        sets: 3,
        workoutId: 5,
      ),
    ];

    for (FinishedExercise finished in finishedExercises) {
      finished.date = finished.tmpDate!;
    }

    List<WaterIntake> waterIntakes = [
      WaterIntake(
        date: DateTime.fromMicrosecondsSinceEpoch(1684015200000000),
        maxWaterIntake: 3.8,
        waterIntake: 3.9000000000000004,
      ),
      WaterIntake(
        date: DateTime.fromMicrosecondsSinceEpoch(1684101600000000),
        maxWaterIntake: 4.6,
        waterIntake: 3.5,
      ),
      WaterIntake(
        date: DateTime.fromMicrosecondsSinceEpoch(1684188000000000),
        maxWaterIntake: 3,
        waterIntake: 3.8500000000000005,
      ),
      WaterIntake(
        date: DateTime.fromMicrosecondsSinceEpoch(1684447200000000),
        maxWaterIntake: 3,
        waterIntake: 2.25,
      ),
      WaterIntake(
        date: DateTime.fromMicrosecondsSinceEpoch(1684533600000000),
        maxWaterIntake: 4.3,
        waterIntake: 4,
      ),
      WaterIntake(
        date: DateTime.fromMicrosecondsSinceEpoch(1684620000000000),
        maxWaterIntake: 3,
        waterIntake: 2.5,
      ),
    ];

    List<SleepCycle> sleepCycles = [
      SleepCycle(
        bedTime: DateTime.fromMicrosecondsSinceEpoch(1980000000),
        date: DateTime.fromMicrosecondsSinceEpoch(1683928800000000),
        sleepTime: 490,
        wakeUpTime: DateTime.fromMicrosecondsSinceEpoch(31380000000),
      ),
      SleepCycle(
        bedTime: DateTime.fromMicrosecondsSinceEpoch(3360000000),
        date: DateTime.fromMicrosecondsSinceEpoch(1684015200000000),
        sleepTime: 605,
        wakeUpTime: DateTime.fromMicrosecondsSinceEpoch(2760000000),
      ),
      SleepCycle(
        bedTime: DateTime.fromMicrosecondsSinceEpoch(14520000000),
        date: DateTime.fromMicrosecondsSinceEpoch(1684101600000000),
        sleepTime: 539,
        wakeUpTime: DateTime.fromMicrosecondsSinceEpoch(1684533600000000),
      ),
      SleepCycle(
        bedTime: DateTime.fromMicrosecondsSinceEpoch(4680000000),
        date: DateTime.fromMicrosecondsSinceEpoch(1684188000000000),
        sleepTime: 414,
        wakeUpTime: DateTime.fromMicrosecondsSinceEpoch(29520000000),
      ),
      SleepCycle(
        bedTime: DateTime.fromMicrosecondsSinceEpoch(11700000000),
        date: DateTime.fromMicrosecondsSinceEpoch(1684447200000000),
        sleepTime: 614,
        wakeUpTime: DateTime.fromMicrosecondsSinceEpoch(48480000000),
      ),
      SleepCycle(
        bedTime: DateTime.fromMicrosecondsSinceEpoch(-3600000000),
        date: DateTime.fromMicrosecondsSinceEpoch(1684533600000000),
        sleepTime: 489,
        wakeUpTime: DateTime.fromMicrosecondsSinceEpoch(25740000000),
      ),
      SleepCycle(
        bedTime: DateTime.fromMicrosecondsSinceEpoch(7140000000),
        date: DateTime.fromMicrosecondsSinceEpoch(1684620000000000),
        sleepTime: 538,
        wakeUpTime: DateTime.fromMicrosecondsSinceEpoch(39360000000),
      ),
    ];

    await isar.writeTxn(() async {
      final pull = Group()..name = "Pull";
      final push = Group()..name = "Push";
      final legs = Group()..name = "Legs";
      final user = User();

      // Insert prepared data
      await isar.workouts.putAll(preparedWorkouts);
      await isar.finishedExercises.putAll(finishedExercises);
      await isar.waterIntakes.putAll(waterIntakes);
      await isar.sleepCycles.putAll(sleepCycles);

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

      isar.users.put(user);
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

// Get Exercise by ID
  Future<Exercise?> getExerciseById(int eID) async {
    final isar = await _isar;

    return isar.exercises.get(eID);
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

  // Check if a workout with same date already exists - check only date not time
  Future<bool> checkIfWorkoutExists(DateTime date) async {
    final isar = await _isar;
    final workout = await isar.workouts
        .where()
        .filter()
        .dateEqualTo(DateTime(date.year, date.month, date.day, 0, 0, 0))
        .findFirst();

    return workout != null;
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

// Get all FinishedExercises for a certain workoutName
  Future<List<FinishedExercise>> getFinishedExercisesForWorkout(int wID) async {
    final isar = await _isar;

    return isar.finishedExercises
        .where()
        .filter()
        .workoutIdEqualTo(wID)
        .findAll();
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

  // Get workout by ID
  Future<Workout?> getWorkoutById(int id) async {
    final isar = await _isar;
    return isar.workouts.get(id);
  }

  // Get user by ID
  Future<User?> getUserById(int id) async {
    final isar = await _isar;
    return isar.users.get(id);
  }

  // Update user's premium attribute
  Future<void> updateUserPremium(int id, bool isPremium) async {
    final isar = await _isar;
    User? user = await getUserById(id);

    if (user != null) {
      user.premium = isPremium;
      await isar.writeTxn(() {
        return isar.users.put(user);
      });
    }
  }
}
