import 'package:flutter/material.dart';
import 'package:flutter_application_1/isar-db/isar-service.dart';
import 'package:flutter_application_1/statistics/exercise_statistics.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../models/finished_exercise.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  final int workoutId;

  WorkoutDetailsScreen({required this.workoutId});

  @override
  // ignore: library_private_types_in_public_api
  _WorkoutDetailsScreenState createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  final _isar = IsarService();
  Workout? _workout;
  List<FinishedExercise>? _finishedExercises;

  @override
  void initState() {
    super.initState();
    _loadWorkoutDetails();
  }

  Future<void> _loadWorkoutDetails() async {
    _workout = await _isar.getWorkoutById(widget.workoutId);
    _finishedExercises =
        await _isar.getFinishedExercisesForWorkout(widget.workoutId);

    // Fetch exercise names for each finished exercise
    for (var finishedExercise in _finishedExercises!) {
      print("for finished exercise: ${finishedExercise.exerciseId}");

      Exercise? exercise =
          await _isar.getExerciseById(finishedExercise.exerciseId);
      if (exercise != null) {
        finishedExercise.exerciseName = exercise.name;
      }
    }

    setState(() {
      // Trigger a rebuild to reflect the loaded data
    });
  }

  String _formatDuration(int durationInSeconds) {
    durationInSeconds = durationInSeconds ~/ 100;

    int hours = durationInSeconds ~/ 3600;
    int minutes = (durationInSeconds % 3600) ~/ 60;

    String formattedDuration = '';
    if (hours > 0) {
      formattedDuration += '$hours h ';
    }
    if (minutes > 0) {
      formattedDuration += '$minutes min';
    }
    return formattedDuration.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 233, 241),
      appBar: AppBar(
        title: Text(
          "WORKOUT DETAILS",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2.1,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.deepPurple,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _workout != null
                      ? _workout!.date.toString().substring(0, 10)
                      : '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _workout != null ? _formatDuration(_workout!.duration) : '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  _finishedExercises != null ? _finishedExercises!.length : 0,
              itemBuilder: (context, index) {
                FinishedExercise exercise = _finishedExercises![index];
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1),
                        right: BorderSide(width: 1),
                        left: BorderSide(width: 1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          exercise.exerciseName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1),
                              bottom: BorderSide(width: 1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.accessibility_new),
                                  SizedBox(width: 8),
                                  Text('${exercise.sets}'),
                                ],
                              ),
                              SizedBox(width: 16),
                              Row(
                                children: [
                                  Icon(Icons.refresh),
                                  SizedBox(width: 8),
                                  Text('${exercise.reps}'),
                                ],
                              ),
                              SizedBox(width: 16),
                              Row(
                                children: [
                                  Icon(Icons.fitness_center),
                                  SizedBox(width: 8),
                                  Text('${exercise.resistance}'),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 8),
                                  IconButton(
                                    icon: Icon(
                                      Icons.bar_chart,
                                      color: Colors.purple,
                                    ),
                                    onPressed: () {
                                      // Route to exercise_statistics.dart with exerciseId
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ExerciseStatsPage(
                                                  exerciseId:
                                                      exercise.exerciseId),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
