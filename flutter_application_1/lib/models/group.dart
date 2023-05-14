import 'package:isar/isar.dart';

import 'exercise.dart';

part 'group.g.dart';

@Collection()
class Group {
  Id id = Isar.autoIncrement;
  late String name;
}
