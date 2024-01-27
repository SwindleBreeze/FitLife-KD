import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter_application_1/isar-db/isar-service.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/finished_exercise.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import 'components/quick_information_widget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseStatsPage extends StatefulWidget {
  final Id exerciseId;
  const ExerciseStatsPage({Key? key, required this.exerciseId})
      : super(key: key);

  @override
  _ExerciseStatsPageState createState() => _ExerciseStatsPageState();
}

class _ExerciseStatsPageState extends State<ExerciseStatsPage> {
  final isarService = IsarService();

  List<DChartTimeData> _setDataAllTimes = [];
  List<DChartTimeData> _setData3Months = [];
  List<DChartTimeData> _setDataLastMonth = [];

  List<DChartTimeData> _repsDataAllTimes = [];
  List<DChartTimeData> _repsData3Months = [];
  List<DChartTimeData> _repsDataLastMonth = [];

  List<DChartTimeData> _resistanceDataAllTimes = [];
  List<DChartTimeData> _resistanceData3Months = [];
  List<DChartTimeData> _resistanceDataLastMonth = [];

  FinishedExercise? today;
  FinishedExercise? yesterday;
  List<FinishedExercise> lastWeek = [];

  bool visibleAll = true;
  bool visible1M = false;
  bool visible3M = false;

  double avgSets = 0;
  double avgReps = 0;
  double avgResistance = 0;

  @override
  void initState() {
    _getExerciseData();

    super.initState();
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate1 = formatter.format(date1);
    String formattedDate2 = formatter.format(date2);

    return formattedDate1 == formattedDate2;
  }

  Future<void> _getExerciseData() async {
    DateTime now = DateTime.now();
    DateTime oneMonthAgo = now.subtract(Duration(days: 30));
    DateTime threeMonthsAgo = now.subtract(Duration(days: 90));

    List<FinishedExercise> exerciseList =
        await isarService.getFinishedExercises();

    //Get finished exercises where workoutId == widget.workoutId
    exerciseList = exerciseList
        .where((element) => element.exerciseId == widget.exerciseId)
        .toList();

    print(widget.exerciseId);

    for (FinishedExercise exercise in exerciseList) {
      if (isSameDate(now, exercise.date)) {
        setState(() {
          today = exercise;
        });
      }

      // Check if it's yesterday intake
      if (isSameDate(exercise.date, now.subtract(Duration(hours: 24)))) {
        yesterday = exercise;
      }

      // Check if it's last week intake
      if (exercise.date.isAfter(now.subtract(Duration(days: 7)))) {
        lastWeek.add(exercise);
        print("Hurra");
      }

      // Check if it's last month intake
      if (exercise.date.isAfter(oneMonthAgo)) {
        _setDataLastMonth
            .add(DChartTimeData(time: exercise.date, value: exercise.sets));
      }

      if (exercise.date.isAfter(oneMonthAgo)) {
        _repsDataLastMonth
            .add(DChartTimeData(time: exercise.date, value: exercise.reps));
      }

      if (exercise.date.isAfter(oneMonthAgo)) {
        _resistanceDataLastMonth.add(
            DChartTimeData(time: exercise.date, value: exercise.resistance));
      }

      // Check if it's last three months
      if (exercise.date.isAfter(threeMonthsAgo)) {
        _setData3Months
            .add(DChartTimeData(time: exercise.date, value: exercise.sets));
      }

      if (exercise.date.isAfter(threeMonthsAgo)) {
        _repsData3Months
            .add(DChartTimeData(time: exercise.date, value: exercise.reps));
      }

      if (exercise.date.isAfter(threeMonthsAgo)) {
        _resistanceData3Months.add(
            DChartTimeData(time: exercise.date, value: exercise.resistance));
      }

      // Add to all data
      _setDataAllTimes
          .add(DChartTimeData(time: exercise.date, value: exercise.sets));
      _repsDataAllTimes
          .add(DChartTimeData(time: exercise.date, value: exercise.reps));
      _resistanceDataAllTimes
          .add(DChartTimeData(time: exercise.date, value: exercise.resistance));
    }

    for (FinishedExercise exercise in lastWeek) {
      avgReps += exercise.reps / lastWeek.length;
      avgResistance += exercise.resistance / lastWeek.length;
      avgSets += exercise.sets / lastWeek.length;
    }

    setState(() {
      avgReps = avgReps;
      avgResistance = avgResistance;
      avgSets = avgSets;
      visible1M = false;
      visible3M = false;
      visibleAll = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          'STATISTICS',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 4.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Column(children: [
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              color: Colors.blue,
            ),
            SizedBox(width: 5),
            Text(
              'Sets',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 20),
            Container(
              width: 20,
              height: 20,
              color: Colors.red,
            ),
            SizedBox(width: 5),
            Text(
              'Reps',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 20),
            Container(
              width: 20,
              height: 20,
              color: Colors.green,
            ),
            SizedBox(width: 5),
            Text(
              'Resistance',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 35,
          child: Stack(
            children: [
              Visibility(
                visible: visible3M,
                child: Container(
                  height: 40,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 11, 49, 79),
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      'Exercise Statistics - Last 3 Months',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: visible1M,
                child: Container(
                  height: 40,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 11, 49, 79),
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      'Exercise Statistics - Last Month',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: visibleAll,
                child: Container(
                  height: 40,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 11, 49, 79),
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      'Exercise Statistics - All Time',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          width: 350,
          child: Stack(
            children: [
              Visibility(
                visible: visible3M,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: DChartTime(
                    fillColor: (group, data, index) {
                      return Color.fromARGB(255, 11, 49, 79);
                    },
                    // areaColor: (group, data, index) {
                    //   return Color.fromARGB(255, 67, 25, 126);
                    // },
                    chartRender: DRenderLine(
                      showArea: true,
                      showLine: true,
                      showPoint: true,
                    ),
                    showDomainLine: true,
                    showMeasureLine: true,
                    measureLabel: (value) => '$value',
                    domainLabel: (dateTime) {
                      return DateFormat('d MMM').format(dateTime!);
                    },
                    groupData: [
                      DChartTimeGroup(
                        id: 'Sets',
                        color: Colors.blue,
                        data: _setData3Months,
                      ),
                      DChartTimeGroup(
                        id: 'Reps',
                        color: Colors.red,
                        data: _repsData3Months,
                      ),
                      DChartTimeGroup(
                        id: 'Resistance',
                        color: Colors.green,
                        data: _resistanceData3Months,
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: visible1M,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: DChartTime(
                    fillColor: (group, data, index) {
                      return Color.fromARGB(255, 11, 49, 79);
                    },
                    // areaColor: (group, data, index) {
                    //   return Color.fromARGB(255, 67, 25, 126);
                    // },
                    chartRender: DRenderLine(
                      showArea: true,
                      showLine: true,
                      showPoint: true,
                    ),
                    showDomainLine: true,
                    showMeasureLine: true,
                    measureLabel: (value) => '$value',
                    domainLabel: (dateTime) {
                      return DateFormat('d MMM').format(dateTime!);
                    },
                    groupData: [
                      DChartTimeGroup(
                        id: 'Sets',
                        color: Colors.blue,
                        data: _setDataLastMonth,
                      ),
                      DChartTimeGroup(
                        id: 'Reps',
                        color: Colors.red,
                        data: _repsDataLastMonth,
                      ),
                      DChartTimeGroup(
                        id: 'Resistance',
                        color: Colors.green,
                        data: _resistanceDataLastMonth,
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: visibleAll,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: DChartTime(
                    fillColor: (group, data, index) {
                      return Color.fromARGB(255, 11, 49, 79);
                    },
                    // areaColor: (group, data, index) {
                    //   return Color.fromARGB(255, 67, 25, 126);
                    // },
                    chartRender: DRenderLine(
                      strokeWidth: 3,
                      showArea: true,
                      showLine: true,
                      showPoint: true,
                    ),
                    showDomainLine: true,
                    showMeasureLine: true,
                    measureLabel: (value) => '$value',
                    domainLabel: (dateTime) {
                      return DateFormat('d MMM').format(dateTime!);
                    },
                    groupData: [
                      DChartTimeGroup(
                        id: 'Sets',
                        color: Colors.blue,
                        data: _setDataAllTimes,
                      ),
                      DChartTimeGroup(
                        id: 'Reps',
                        color: Colors.red,
                        data: _repsDataAllTimes,
                      ),
                      DChartTimeGroup(
                        id: 'Resistance',
                        color: Colors.green,
                        data: _resistanceDataAllTimes,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    visible1M = false;
                    visible3M = false;
                    visibleAll = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 11, 49, 79),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'All Time',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    visible1M = false;
                    visible3M = true;
                    visibleAll = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 11, 49, 79),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Last 3 Months',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    visible1M = true;
                    visible3M = false;
                    visibleAll = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 11, 49, 79),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Last Month',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        today != null
            ? QuickInformation(
                first: today?.sets.toStringAsFixed(2),
                second: today?.reps.toStringAsFixed(2),
                third: today?.resistance.toStringAsFixed(2),
                title: "Today",
                firstIcon: Icons.bar_chart,
                secondIcon: Icons.replay,
                thirdIcon: Icons.expand,
              )
            : SizedBox(height: 0),
        SizedBox(height: 35),
        yesterday != null
            ? QuickInformation(
                title: "Yesterday",
                first: yesterday?.sets.toStringAsFixed(2),
                second: yesterday?.reps.toStringAsFixed(2),
                third: yesterday?.resistance.toStringAsFixed(2),
                firstIcon: Icons.bar_chart,
                secondIcon: Icons.replay,
                thirdIcon: Icons.expand,
              )
            : SizedBox(height: 0),
        SizedBox(height: 35),
        lastWeek.isNotEmpty
            ? QuickInformation(
                title: "Last Week Average",
                first: avgSets.toStringAsFixed(2),
                second: avgReps.toStringAsFixed(2),
                third: avgResistance.toStringAsFixed(2),
                firstIcon: Icons.bar_chart,
                secondIcon: Icons.replay,
                thirdIcon: Icons.expand,
              )
            : SizedBox(height: 0),
      ]),
    );
  }
}
