import 'package:flutter_application_1/models/group.dart';
import 'package:isar/isar.dart';
import 'package:flutter_application_1/models/workout.dart';

part 'exercise.g.dart';

@Collection()
class Exercise {
  Id id = Isar.autoIncrement;
  late String name;
  late String description;
  late int groupid;
}
