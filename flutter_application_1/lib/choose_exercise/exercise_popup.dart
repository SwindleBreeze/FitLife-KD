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
  final IsarService isarService = IsarService();
  final List<Exercise> _exerciseList;

  ExerciseModal({
    Key? key,
    required this.onPressed,
    required List<Exercise> exercises,
  })  : _exerciseList = exercises,
        super(key: key);

  @override
  Widget build(BuildContext context) {

    DateTime currentDate = DateTime.now();
    currentDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    return FutureBuilder<bool>(
      future: isarService.checkIfWorkoutExists(currentDate),
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == true) {
          // Workout exists for today
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
                    'A good life also means a social life, go out there and have some fun :)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Workout doesn't exist for today
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
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 16),
                  BeginExerciseButton(
                    text: 'Begin',
                    onPressed: () {
                      // Build exercise handler
                      Workout workout = Workout(duration: 0);
                      isarService.addWorkout(workout);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExerciseHandler(exerciseList: _exerciseList),
                        ),
                      );
                    },
                  ),
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
      },
    );
  }
}
