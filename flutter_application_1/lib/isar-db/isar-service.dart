import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:flutter_application_1/models/group.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/user.dart';

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
      return await Isar.open([ExerciseSchema, GroupSchema],
          inspector: true, directory: path);
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
        final exercise = Exercise()..name = ex['name'];
        exercise.groupid = pull.id;
        await isar.exercises.put(exercise);
      }

      for (var ex in pushExercises) {
        final exercise = Exercise()..name = ex['name'];
        exercise.groupid = push.id;
        await isar.exercises.put(exercise);
      }

      for (var ex in legsExercises) {
        final exercise = Exercise()..name = ex['name'];
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
    return exercises.take(30).toList();
  }

  // Insert exercise (expected Exercise object)
  Future<void> addExercise(Exercise exercise) async {
    final isar = await _isar;
    isar.writeTxn<Exercise>(() {
      isar.exercises.put(exercise);
      return Future.value(exercise.id as FutureOr<Exercise>?);
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
}
