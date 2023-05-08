import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:flutter_application_1/models/group.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/user.dart';

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

  // Insert default data if the database is empty
  Future<Isar> insertIfEmpty() async {
    final isar = await _isar;
    if (isar.groups.count() == 0) {
      isar.writeTxn(() {
        isar.groups.put(Group()..name = "Pull");
        isar.groups.put(Group()..name = "Push");
        isar.groups.put(Group()..name = "Legs");
        return Future.value(null);
      });
    }
    return Future.value(Isar.getInstance());
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
