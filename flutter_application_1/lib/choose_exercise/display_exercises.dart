import 'package:flutter/material.dart';
import 'package:flutter_application_1/isar-db/isar-service.dart';

import 'begin_exercise_button.dart';

class display_exercise extends StatefulWidget {
  final String groupName;

  final isar_service = IsarService();

  display_exercise({required this.groupName});

  @override
  _display_exerciseState createState() => _display_exerciseState();
}

class _display_exerciseState extends State<display_exercise> {
  late List<String> _exercises;

  @override
  void initState() {
    super.initState();
    _getExercises();
  }

  Future<void> _getExercises() async {
    final isar = IsarService.instance;
    final allExercises = await isar.getExercises();
    final exerciseNames = allExercises.map((e) => e.name).toList();

    final exercises =
        exerciseNames.where((e) => e == widget.groupName).toList();

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
                  exercise: exercise,
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
    );
  }
}

class ExerciseDetails extends StatefulWidget {
  final String exercise;

  ExerciseDetails({required this.exercise});

  @override
  _ExerciseDetailsState createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise),
      ),
      body: Center(
        child: Text('Details for ${widget.exercise}'),
      ),
    );
  }
}
