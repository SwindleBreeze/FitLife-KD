import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter_application_1/isar-db/isar-service.dart';
import 'package:intl/intl.dart';

import '../models/water_intake.dart';
import 'components/quick_information_widget.dart';

class WaterStatsPage extends StatefulWidget {
  const WaterStatsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WaterStatsPageState createState() => _WaterStatsPageState();
}

class _WaterStatsPageState extends State<WaterStatsPage> {
  final isarService = IsarService();

  List<DChartTimeData> _dataAllTimes = [];
  List<DChartTimeData> _data3Months = [];
  List<DChartTimeData> _dataLastMonth = [];

  WaterIntake? today;
  WaterIntake? yesterday;
  List<WaterIntake> lastWeek = [];

  bool visibleAll = true;
  bool visible1M = false;
  bool visible3M = false;

  double avgWaterIntake = 0;
  double avgMaxWaterIntake = 0;

  @override
  void initState() {
    // Read data from database
    _getWaterIntakeData();

    super.initState();
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    // Format the dates to compare only the date component
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate1 = formatter.format(date1);
    String formattedDate2 = formatter.format(date2);

    // Compare the formatted dates
    return formattedDate1 == formattedDate2;
  }

  Future<void> _getWaterIntakeData() async {
    DateTime now = DateTime.now();
    DateTime oneMonthAgo = now.subtract(Duration(days: 30));
    DateTime threeMonthsAgo = now.subtract(Duration(days: 90));

    List<WaterIntake> waterIntakeList = await isarService.getWaterIntakes();

    for (WaterIntake intake in waterIntakeList) {
      // Check if it's today intake
      if (isSameDate(now, intake.date)) {
        setState(() {
          today = intake;
        });
      }

      // Check if it's yesterday intake
      if (isSameDate(intake.date, now.subtract(Duration(hours: 24)))) {
        yesterday = intake;
      }

      // Check if it's last week intake
      if (intake.date.isAfter(now.subtract(Duration(days: 7)))) {
        lastWeek.add(intake);
        print("Hurra");
      }

      // Check if it's last month intake
      if (intake.date.isAfter(oneMonthAgo)) {
        _dataLastMonth
            .add(DChartTimeData(time: intake.date, value: intake.waterIntake));
      }

      // Check if it's last three months intake
      if (intake.date.isAfter(threeMonthsAgo)) {
        _data3Months
            .add(DChartTimeData(time: intake.date, value: intake.waterIntake));
      }

      // Add to all data
      _dataAllTimes
          .add(DChartTimeData(time: intake.date, value: intake.waterIntake));
    }

    for (WaterIntake intake in lastWeek) {
      avgWaterIntake += intake.waterIntake / lastWeek.length;
      avgMaxWaterIntake += intake.maxWaterIntake / lastWeek.length;
    }

    setState(() {
      avgWaterIntake = avgWaterIntake;
      avgMaxWaterIntake = avgMaxWaterIntake;
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
          'STATISTICS - WATER',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 4.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Column(children: [
        SizedBox(height: 20),
        SizedBox(
          height: 40,
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
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Text(
                      'Water Intake Statistics - Last 3 Months',
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
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Text(
                      'Water Intake Statistics - Last Month',
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
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Visibility(
                    visible: visibleAll,
                    child: Center(
                      child: Text(
                        'Water Intake Statistics - All Time',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
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
                    areaColor: (group, data, index) {
                      return Color.fromARGB(255, 67, 25, 126);
                    },
                    chartRender: DRenderLine(
                      showArea: true,
                      showLine: true,
                      showPoint: true,
                    ),
                    showDomainLine: true,
                    showMeasureLine: true,
                    measureLabel: (value) => '${value}',
                    domainLabel: (dateTime) {
                      // [DateFormat] from intl package
                      return DateFormat('d MMM').format(dateTime!);
                    },
                    groupData: [
                      DChartTimeGroup(
                        id: 'Keyboard',
                        color: Colors.blue,
                        data: _data3Months,
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
                    areaColor: (group, data, index) {
                      return Color.fromARGB(255, 67, 25, 126);
                    },
                    chartRender: DRenderLine(
                      showArea: true,
                      showLine: true,
                      showPoint: true,
                    ),
                    showDomainLine: true,
                    showMeasureLine: true,
                    measureLabel: (value) => '${value}',
                    domainLabel: (dateTime) {
                      // [DateFormat] from intl package
                      return DateFormat('d MMM').format(dateTime!);
                    },
                    groupData: [
                      DChartTimeGroup(
                        id: 'Keyboard',
                        color: Colors.blue,
                        data: _dataLastMonth,
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
                    areaColor: (group, data, index) {
                      return Color.fromARGB(255, 67, 25, 126);
                    },
                    chartRender: DRenderLine(
                      strokeWidth: 3,
                      showArea: true,
                      showLine: true,
                      showPoint: true,
                    ),
                    showDomainLine: true,
                    showMeasureLine: true,
                    measureLabel: (value) => '${value}',
                    domainLabel: (dateTime) {
                      // [DateFormat] from intl package
                      return DateFormat('d MMM').format(dateTime!);
                    },
                    groupData: [
                      DChartTimeGroup(
                        id: 'Keyboard',
                        color: Colors.blue,
                        data: _dataAllTimes,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
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
                        borderRadius: BorderRadius.circular(10))),
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
                        borderRadius: BorderRadius.circular(10))),
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
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  'Last Month',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 45),
        today != null
            ? QuickInformation(
                first: today?.waterIntake.toString(),
                second: today?.maxWaterIntake.toString(),
                title: "Today",
                firstIcon: Icons.water_drop,
                secondIcon: Icons.track_changes_outlined,
              )
            : SizedBox(height: 0),
        SizedBox(height: 35),
        yesterday != null
            ? QuickInformation(
                title: "Yesterday",
                first: yesterday?.waterIntake.toString(),
                second: yesterday?.maxWaterIntake.toString(),
                firstIcon: Icons.water_drop,
                secondIcon: Icons.track_changes_outlined,
              )
            : SizedBox(height: 0),
        SizedBox(height: 35),
        lastWeek != []
            ? QuickInformation(
                title: "Last Week Average",
                first: avgWaterIntake.toStringAsFixed(2),
                second: avgMaxWaterIntake.toStringAsFixed(2),
                firstIcon: Icons.water_drop,
                secondIcon: Icons.track_changes_outlined,
              )
            : SizedBox(height: 0),
      ]),
    );
  }
}
