/*
  To do:
  * make sure that whenever the new Workout is added to DB (workout is finished),
    that you update the event lists (call _updateEventsFromDB)
*/

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/statistics/sleep_statistics.dart';
import 'package:flutter_application_1/statistics/wasser_intake_statistics.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'add_water_page/add_water_page.dart';
import 'components/workout_details_screen.dart';
import 'models/workout.dart';
import 'sleep_and_rest/main_page.dart';
import 'choose_exercise/display_exercises.dart';
import 'package:table_calendar/table_calendar.dart';

import 'isar-db/isar-service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isar = IsarService();
  await isar.insertIfEmpty();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FitLife',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: PermissionRequestWidget(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _isar = IsarService();
  late DateTime _selectedDate;
  Map<String, List<Event>> _events = {
    "1999-9-9": [Event("first")]
  };

  // Workout modal variables
  int wID = 0;

  Color tmpColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _updateEventsFromDB(_isar);
  }

  int workoutIdFormat(String strWorkoutID) {
    strWorkoutID = strWorkoutID.substring(1);
    strWorkoutID = strWorkoutID.substring(0, strWorkoutID.length - 1);
    int wID = int.parse(strWorkoutID);

    return wID;
  }

  Future<void> _updateEventsFromDB(IsarService isar) async {
    // Get the list of workouts from the IsarService
    List<Workout> workouts = await isar.getWorkouts();

    // Create an empty map to store the events
    Map<String, List<Event>> events = {};

    // Iterate over the workouts and add them to the events map
    for (Workout workout in workouts) {
      // Convert the workout date to a string key for the map
      String key = workout.date.toIso8601String().substring(0, 10);

      // Create an Event object from the workout
      Event event = Event(workout.id.toString());

      // Add the event to the list of events for this date
      events.putIfAbsent(key, () => []).add(event);
    }

    setState(() {
      _events = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 185, 198, 221),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "FITLIFE",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2.1,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.blue,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 0, 34, 79), width: 5),
                        shape: BoxShape.rectangle,
                      ),
                    );
                  }
                  return null;
                },
              ),
              selectedDayPredicate: (date) {
                return isSameDay(date, _selectedDate);
              },
              onDaySelected: (date, events) {
                setState(() {
                  String day = date
                      .toString()
                      .substring(0, date.toIso8601String().length - 1)
                      .substring(0, 10);
                  _selectedDate = date;

                  if (_events.containsKey(day)) {
                    int id = workoutIdFormat(_events[day].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WorkoutDetailsScreen(workoutId: id),
                      ),
                    );
                  }
                });
              },
              pageAnimationEnabled: true,
              pageJumpingEnabled: true,
              calendarFormat: CalendarFormat.week,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.9,
                    colors: [Colors.blue, Colors.purple],
                  ),
                ),
                isTodayHighlighted: false,
                weekendDecoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.9,
                    colors: [Colors.blue, Colors.purple],
                  ),
                ),
                defaultDecoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.9,
                    colors: [Colors.blue, Colors.purple],
                  ),
                ),
                markersAlignment: Alignment.center,
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
              firstDay: DateTime(2022, 5, 5),
              lastDay: DateTime(2024, 5, 5),
              focusedDay: _selectedDate,
              eventLoader: (day) {
                return _getEventsForDay(day);
              },
            ),
            SizedBox(height: 20),

            // Other UI components
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Water
                GestureDetector(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 700),
                    height: 45,
                    width: 45,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      color: tmpColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Icon(
                      Icons.water_drop,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      tmpColor = Color.fromARGB(255, 2, 33, 58);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddWaterPage()),
                    );
                  },
                ),
                // Sleep
                GestureDetector(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 700),
                    height: 45,
                    width: 45,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      color: tmpColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Icon(
                      Icons.self_improvement_sharp,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      tmpColor = Color.fromARGB(255, 2, 33, 58);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MySleepPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMenu<String>(
            context: context,
            position: RelativeRect.fromLTRB(
              MediaQuery.of(context).size.width - 130,
              MediaQuery.of(context).size.height - 260,
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            items: [
              PopupMenuItem<String>(
                value: 'legs',
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Legs'),
                ),
                onTap: () {
                  print("Legs was pressed");
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayExercise(
                          groupName: 'Legs',
                        ),
                      ),
                    ).then((result) {
                      _updateEventsFromDB(_isar);
                    });
                  });
                },
              ),
              PopupMenuDivider(
                height: 10,
              ),
              PopupMenuItem<String>(
                value: 'push',
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Push'),
                ),
                onTap: () {
                  print("Push was pressed");
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayExercise(
                          groupName: 'Push',
                        ),
                      ),
                    ).then((result) {
                      _updateEventsFromDB(_isar);
                    });
                  });
                },
              ),
              PopupMenuDivider(
                height: 10,
              ),
              PopupMenuItem<String>(
                value: 'pull',
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Pull'),
                ),
                onTap: () {
                  print("Pull was pressed");
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayExercise(
                          groupName: 'Pull',
                        ),
                      ),
                    ).then((result) {
                      _updateEventsFromDB(_isar);
                    });
                  });
                },
              ),
            ],
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    String formattedDay = day
        .toString()
        .substring(0, day.toIso8601String().length - 1)
        .substring(0, 10);
    return _events[formattedDay] ?? [];
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class PermissionRequestWidget extends StatefulWidget {
  final Widget child;

  const PermissionRequestWidget({Key? key, required this.child})
      : super(key: key);

  @override
  _PermissionRequestWidgetState createState() =>
      _PermissionRequestWidgetState();
}

class _PermissionRequestWidgetState extends State<PermissionRequestWidget> {
  bool permissionsGranted = false;

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    var storageStatus = await Permission.storage.status;
    var locationStatus = await Permission.location.status;

    if (!storageStatus.isGranted || !locationStatus.isGranted) {
      // If the permissions are not granted, request them
      await requestPermissions();
    }

    setState(() {
      permissionsGranted = true;
    });
  }

  Future<void> requestPermissions() async {
    await Permission.storage.request();
    await Permission.location.request();
    // internet requests
  }

  @override
  Widget build(BuildContext context) {
    if (!permissionsGranted) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return widget.child;
  }
}
