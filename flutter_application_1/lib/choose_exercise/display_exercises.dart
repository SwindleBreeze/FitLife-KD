import 'package:flutter/material.dart';
import 'package:flutter_application_1/isar-db/isar-service.dart';
import 'package:flutter_application_1/models/exercise.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:isar/isar.dart';

import 'begin_exercise_button.dart';
import 'exercise_popup.dart';

class DisplayExercise extends StatefulWidget {
  final String groupName;
  final isar_service = IsarService();

  DisplayExercise({required this.groupName});

  @override
  DisplayExerciseState createState() => DisplayExerciseState();
}

class DisplayExerciseState extends State<DisplayExercise> {
  late List<Exercise> _exercises = [];

  late Id groupid;

  @override
  void initState() {
    super.initState();
    _getExercises();
  }

  Future<void> _getExercises() async {
    final isar = IsarService.instance;
    final allExercises = await isar.getExercises();

    final allGroups = await isar.getGroups();
    // find group id by widget.GroupName
    final groupId = allGroups.firstWhere((g) => g.name == widget.groupName).id;
    groupid = groupId;
    // find exercises where exercise group is groupId
    final exercises = allExercises.where((e) => e.groupid == groupId).toList();

    setState(() {
      _exercises = exercises;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Exercise'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                final exercise = _exercises[index];
                return begin_exercise_button(
                  exercise: exercise.name,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExerciseDetails(exercise: exercise),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Show a dialog with a form for inserting exercise name and description
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String exerciseName = '';
                    String exerciseDescription = '';
                    return AlertDialog(
                      title: Text('Add Exercise'),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Exercise Name',
                              ),
                              onChanged: (value) {
                                exerciseName = value;
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Exercise Description',
                              ),
                              onChanged: (value) {
                                exerciseDescription = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Add the exercise to the list
                            Exercise newExercise = Exercise()
                              ..name = exerciseName
                              ..description = exerciseDescription;
                            newExercise.groupid = groupid;
                            widget.isar_service.addExercise(newExercise);
                            setState(() {
                              _exercises.add(newExercise);
                            });

                            Navigator.of(context).pop();
                          },
                          child: Text('ADD'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.add),
              label: Text("Add Exercise"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ExerciseModal(
                      onPressed: () {
                        // do something when the BeginExerciseButton is pressed
                      },
                      exercises: _exercises,
                    );
                  },
                );
              },
              icon: Icon(Icons.timer),
              label: Text("Begin Workout"),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseDetails extends StatefulWidget {
  final Exercise exercise;
  ExerciseDetails({required this.exercise});

  @override
  _ExerciseDetailsState createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: HtmlWidget(widget.exercise.description),
        ),
      ),
    );
  }
}
