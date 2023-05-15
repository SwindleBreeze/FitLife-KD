import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/workout.dart';
import 'package:flutter_application_1/isar-db/isar-service.dart';

import 'exercise_handle.dart';

class BeginExerciseButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BeginExerciseButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        onPressed();
      },
      child: Text(text),
    );
  }
}

class ExerciseModal extends StatelessWidget {
  final VoidCallback onPressed;
  final isarService = IsarService();

  List<Exercise> _exerciseList = [];

  ExerciseModal(
      {Key? key, required this.onPressed, required List<Exercise> exercises})
      : super(key: key) {
    _exerciseList = exercises;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you ready to begin?',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
            SizedBox(height: 16),
            BeginExerciseButton(
                text: 'Begin',
                onPressed: () {
                  // build exercise handler
                  Workout workout = Workout(duration: 0);
                  isarService.addWorkout(workout);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ExerciseHandler(exerciseList: _exerciseList),
                    ),
                  );
                }),
            SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
