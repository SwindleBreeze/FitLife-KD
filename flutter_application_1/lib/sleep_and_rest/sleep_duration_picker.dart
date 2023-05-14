import 'package:time_duration_picker/time_duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
import '../models/sleep_cycle.dart';

// Isar service
import '../isar-db/isar-service.dart';

class SetAlarm extends StatefulWidget {
  const SetAlarm({Key? key}) : super(key: key);

  @override
  State<SetAlarm> createState() => _SetAlarmState();
}

class _SetAlarmState extends State<SetAlarm> {
  final isarService = IsarService();
  String alarmTime = "12:00 PM";
  String bedTime = "12:00 AM";
  String sleepDuration = "12 hr 00 min";
  String avgSleep = "";
  String yesterdaySleep = "";

  @override
  void initState() {
    super.initState();
    _loadValuesFromDatabase();
  }

  void _loadValuesFromDatabase() async {
    avgSleep = await getLast7DayAverageSleepTime();
    yesterdaySleep = await getYesterdaySleepDuration();

    DateTime currentDate = DateTime.now();
    currentDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day);

    SleepCycle? sleepCycle = await isarService.getSleepCycleByDate(currentDate);
    if (sleepCycle != null) {
      setState(() {
        String wakeUpTime1 =
            DateFormat('hh:mm a').format(sleepCycle.wakeUpTime);
        String bedTime1 = DateFormat('hh:mm a').format(sleepCycle.bedTime);
        String dur = formatDuration(sleepCycle.sleepTime);

        alarmTime = wakeUpTime1;
        bedTime = bedTime1;
        sleepDuration = dur;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double smallerMarginRatio = 0.025;

    double horizontalPadding = 0.08;

    double verticalPadding = 0.05;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * horizontalPadding, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text("7 Day Avg."),
                ),
                SizedBox(width: 100),
                Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: Text("Yesterday"))
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 30.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(2.0),
                    gradient: LinearGradient(
                        colors: [Colors.indigo, Colors.blueAccent]),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          offset: Offset(2.0, 2.0)),
                    ],
                  ),
                  child: Text(
                    avgSleep,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 100),  
                Container(
                  alignment: Alignment.center,
                  height: 30.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(2.0),
                    gradient: LinearGradient(
                        colors: [Colors.indigo, Colors.blueAccent]),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          offset: Offset(2.0, 2.0)),
                    ],
                  ),
                  child: Text(
                    yesterdaySleep,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * smallerMarginRatio * 1.1),
            TimeDurationPicker(
              diameter: size.width * 0.75,
              icon1Data: Icons.bed,
              icon2Data: Icons.notifications_none,
              knobDecoration:
                  const BoxDecoration(color: Color.fromRGBO(167, 153, 240, 1)),
              clockDecoration: const BoxDecoration(
                  gradient: RadialGradient(colors: [
                Color.fromRGBO(167, 153, 240, 1),
                Colors.white
              ])),
              knobBackgroundDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(218, 224, 238, 1),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.white,
                    Color.fromRGBO(218, 224, 238, 1),
                  ],
                  stops: [0.1, 1],
                ),
              ),
              onIcon1RotatedCallback: (value) {
                setState(() {
                  bedTime = value;
                });
              },
              onIcon2RotatedCallback: (value) {
                setState(() {
                  alarmTime = value;
                });
              },
              setDurationCallback: (value) {
                setState(() {
                  sleepDuration = value;
                });
              },
            ),
            SizedBox(height: size.height * 2 * smallerMarginRatio * 0.75),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: size.width * 0.5,
                child: Text(
                  sleepDuration,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Color.fromRGBO(77, 88, 170, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () async {
                // Define the format of the time string
                DateFormat format = DateFormat("hh:mm a");

                // Parse the time string and convert it to DateTime
                DateTime bedTimeFixed = format.parse(bedTime);
                DateTime alarmTimeFixed = format.parse(alarmTime);

                List<String> parts = sleepDuration.split(' ');
                int hours = int.parse(parts[0]);
                int minutes = int.parse(parts[2]);

                int totalMinutes = hours * 60 + minutes;

                SleepCycle newSleepCycle = SleepCycle(
                  date: DateTime.now(),
                  bedTime: bedTimeFixed,
                  wakeUpTime: alarmTimeFixed,
                  sleepTime: totalMinutes,
                );

                // Check if sleep cycle already exists for the current date
                SleepCycle? existingSleepCycle =
                    await isarService.getSleepCycleByDate(newSleepCycle.date);
                if (existingSleepCycle != null) {
                  // Update the existing sleep cycle
                  existingSleepCycle.bedTime = newSleepCycle.bedTime;
                  existingSleepCycle.wakeUpTime = newSleepCycle.wakeUpTime;
                  existingSleepCycle.sleepTime = newSleepCycle.sleepTime;
                  await isarService.updateSleepCycle(existingSleepCycle);
                } else {
                  // Add a new sleep cycle
                  await isarService.addSleepCycle(newSleepCycle);
                }
              },
            ),
            SizedBox(height: size.height * 0.85 * smallerMarginRatio),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AlarmDescription(
                    iconData: Icons.bed,
                    title: "Bedtime",
                    width: size.width * 0.4,
                    time: bedTime),
                AlarmDescription(
                    iconData: Icons.notifications_none,
                    title: "Wake Up",
                    width: size.width * 0.4,
                    time: alarmTime)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AlarmDescription extends StatefulWidget {
  final IconData iconData;
  final String title;
  final String time;
  final double width;
  const AlarmDescription(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.width,
      required this.time})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AlarmDescriptionState createState() => _AlarmDescriptionState();
}

class _AlarmDescriptionState extends State<AlarmDescription> {
  double horizontalPadding = 0.15;
  double verticalPadding = 0.1;
  double aspectRatio = 0.8;
  late double height;

  @override
  void initState() {
    super.initState();
    height = widget.width / aspectRatio;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: height,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 242, 245),
          borderRadius: BorderRadius.circular(widget.width * 0.25)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * verticalPadding,
            horizontal: widget.width * horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              widget.iconData,
              color: const Color.fromRGBO(167, 153, 240, 1),
              size: height * 0.3,
            ),
            SizedBox(
              width: widget.width * (1 - 2 * horizontalPadding) * 0.63,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      color: Color.fromRGBO(
                        54,
                        61,
                        86,
                        1,
                      ),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: widget.width * (1 - 2 * horizontalPadding),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  widget.time,
                  style: const TextStyle(
                    color: Color.fromRGBO(
                      54,
                      61,
                      86,
                      1,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatDuration(int minutes) {
  int hours = minutes ~/ 60;
  int remainingMinutes = minutes % 60;

  String formattedDuration = '';
  if (hours > 0) {
    formattedDuration += '$hours h ';
  }
  formattedDuration += '$remainingMinutes min';

  return formattedDuration;
}

// Calculate the average sleep time for the last 7 days
Future<String> getLast7DayAverageSleepTime() async {
  DateTime currentDate = DateTime.now();
  DateTime sevenDaysAgo = currentDate.subtract(Duration(days: 6));

  // Fetch sleep cycles from the database for the last 7 days
  var isarService = IsarService();
  List<SleepCycle> sleepCycles =
      await isarService.getSleepCyclesBetweenDates(sevenDaysAgo, currentDate);

  // Calculate the total sleep duration
  int totalMinutes = 0;
  for (SleepCycle sleepCycle in sleepCycles) {
    int sleepDurationMinutes = sleepCycle.sleepTime;
    totalMinutes += sleepDurationMinutes;
  }

  // Calculate the average sleep duration
  double averageMinutes = totalMinutes / sleepCycles.length;

  // Format the average sleep duration as "h h m min"
  String formattedDuration = formatDuration(averageMinutes.toInt());

  return formattedDuration;
}

Future<String> getYesterdaySleepDuration() async {
  DateTime currentDate = DateTime.now();
  currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
  DateTime yesterday = currentDate.subtract(Duration(days: 1));

  // Fetch sleep cycle from the database for yesterday
  var isarService = IsarService();
  SleepCycle? yesterdaySleepCycle =
      await isarService.getSleepCycleByDate(yesterday);

  // Get the sleep duration in minutes for yesterday
  int? sleepDurationMinutes = yesterdaySleepCycle?.sleepTime;
  sleepDurationMinutes ??= 0;

  // Format the sleep duration as "h hr m min"
  String formattedDuration = formatDuration(sleepDurationMinutes);

  return formattedDuration;
}
