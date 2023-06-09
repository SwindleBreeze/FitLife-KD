import 'package:flutter/material.dart';
import 'package:flutter_application_1/isar-db/isar-service.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/finished_exercise.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:isar/isar.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter_application_1/models/workout.dart';

class ExerciseHandler extends StatefulWidget {
  List<Exercise> _exerciseList = [];
  final isar_service = IsarService();

  ExerciseHandler({required List<Exercise> exerciseList})
      : _exerciseList = exerciseList;

  @override
  _ExerciseHandlerState createState() => _ExerciseHandlerState();
}

class _ExerciseHandlerState extends State<ExerciseHandler> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  int currentExerciseIndex = 0;
  int _repetitions = 0;
  int _sets = 0;

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  void _skipExercise() {
    if (currentExerciseIndex + 1 < widget._exerciseList.length) {
      setState(() {
        currentExerciseIndex++;
      });
    } else {
      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      widget.isar_service
          .updateLastWorkoutDuration(_stopWatchTimer.rawTime.value);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Congratulations"),
          content: Text("You have completed all exercises."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _finishExercise() {
    showDialog(
      context: context,
      builder: (context) {
        int? _repetitions;
        int? _sets;
        int? _resistance;
        String _repetitionsError = '';
        String _setsError = '';
        String _resistanceError = '';

        void validateInput(String value, String inputName) {
          if (value.isEmpty) {
            // Clear error message if the field is empty
            if (inputName == 'repetitions')
              _repetitionsError = '';
            else if (inputName == 'sets')
              _setsError = '';
            else if (inputName == 'resistance') _resistanceError = '';
          } else {
            final parsedValue = int.tryParse(value);
            if (parsedValue == null) {
              // Set error message if the input cannot be parsed as an integer
              if (inputName == 'repetitions')
                _repetitionsError = 'Please input only whole numbers';
              else if (inputName == 'sets')
                _setsError = 'Please input only whole numbers';
              else if (inputName == 'resistance')
                _resistanceError = 'Please input only whole numbers';
            } else {
              // Clear error message if the input is a valid number
              if (inputName == 'repetitions')
                _repetitionsError = '';
              else if (inputName == 'sets')
                _setsError = '';
              else if (inputName == 'resistance') _resistanceError = '';
            }
          }
        }

        return AlertDialog(
          title: Text('Enter Repetitions and Sets'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Repetitions',
                  errorText:
                      _repetitionsError.isNotEmpty ? _repetitionsError : null,
                ),
                onChanged: (value) {
                  validateInput(value, 'repetitions');
                  _repetitions = int.tryParse(value);
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Sets',
                  errorText: _setsError.isNotEmpty ? _setsError : null,
                ),
                onChanged: (value) {
                  validateInput(value, 'sets');
                  _sets = int.tryParse(value);
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Resistance',
                  errorText:
                      _resistanceError.isNotEmpty ? _resistanceError : null,
                ),
                onChanged: (value) {
                  validateInput(value, 'resistance');
                  _resistance = int.tryParse(value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_repetitions != null &&
                    _sets != null &&
                    _resistance != null) {
                  Navigator.of(context).pop();
                  var workout_id = await widget.isar_service.getLastWorkout();
                  FinishedExercise finishedExercise = FinishedExercise(
                    exerciseId: widget._exerciseList[currentExerciseIndex].id,
                    reps: _repetitions!,
                    sets: _sets!,
                    resistance: _resistance!,
                    workoutId: workout_id!.id,
                  );
                  widget.isar_service.addFinishedExercise(finishedExercise);
                  setState(() {
                    if (currentExerciseIndex ==
                        widget._exerciseList.length - 1) {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                      widget.isar_service.updateLastWorkoutDuration(
                        _stopWatchTimer.rawTime.value,
                      );
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Congratulations"),
                          content: Text("You have completed all exercises."),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                // Stop timer
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      currentExerciseIndex++;
                    }
                  });
                }
              },
              child: Text('Next Exercise'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Handler'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snapshot) {
                  final value = snapshot.data!;
                  final displayTime = StopWatchTimer.getDisplayTime(value);
                  return Text(
                    displayTime,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
          ListTile(
            title: Text(
              widget._exerciseList[currentExerciseIndex].name,
              style: TextStyle(fontSize: 16),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: _skipExercise,
                  child: Text('Skip Exercise'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _finishExercise,
                  child: Text('Finish Exercise'),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: HtmlWidget(
                  widget._exerciseList[currentExerciseIndex].description,
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Finish Workout?'),
                    content:
                        Text('Are you sure you want to finish the workout?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No')),
                      TextButton(
                          onPressed: () {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.stop);
                            widget.isar_service.updateLastWorkoutDuration(
                                _stopWatchTimer.rawTime.value);

                            // To do: Rebuild calendar

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('Yes')),
                    ],
                  );
                });
          },
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}
