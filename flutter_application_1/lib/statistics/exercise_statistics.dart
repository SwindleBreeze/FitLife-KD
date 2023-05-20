import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter_application_1/isar-db/isar-service.dart';
import 'package:intl/intl.dart';

import '../models/water_intake.dart';
import 'components/quick_information_widget.dart';

class MyStatsPage extends StatefulWidget {
  const MyStatsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyStatsPageState createState() => _MyStatsPageState();
}

class _MyStatsPageState extends State<MyStatsPage> {
  List<DChartTimeData> _dataAllTimes = [];
  List<DChartTimeData> _data3Months = [];
  List<DChartTimeData> _dataLastMonth = [];

  WaterIntake? today;
  WaterIntake? yesterday;
  List<WaterIntake> lastWeek = [];

  final isarService = IsarService();

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
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'STATISTIKA',
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
                child: Text(
                  "Water Intake Statistics (Last 3 Months)",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Visibility(
                visible: visible1M,
                child: Text(
                  "Water Intake Statistics (Last Month)",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Visibility(
                visible: visibleAll,
                child: Text(
                  "Water Intake Statistics (All time)",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 350,
          child: Stack(
            children: [
              Visibility(
                visible: visible3M,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: DChartTime(
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
                        data: _dataAllTimes,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
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
                child: Text('All Time'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    visible1M = false;
                    visible3M = true;
                    visibleAll = false;
                  });
                },
                child: Text('Last 3 Months'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    visible1M = true;
                    visible3M = false;
                    visibleAll = false;
                  });
                },
                child: Text('Last Month'),
              ),
            ],
          ),
        ),
        SizedBox(height: 45),
        today != null
            ? QuickInformation(
                first: today?.waterIntake,
                second: today?.maxWaterIntake,
                title: "Today",
                firstIcon: Icons.water_drop,
                secondIcon: Icons.track_changes_outlined,
              )
            : SizedBox(height: 0),
        SizedBox(height: 35),
        yesterday != null
            ? QuickInformation(
                title: "Yesterday",
                first: yesterday?.waterIntake,
                second: yesterday?.maxWaterIntake,
                firstIcon: Icons.water_drop,
                secondIcon: Icons.track_changes_outlined,
              )
            : SizedBox(height: 0),
        SizedBox(height: 35),
        lastWeek != []
            ? QuickInformation(
                title: "Last Week Average",
                first: avgWaterIntake,
                second: avgMaxWaterIntake,
                firstIcon: Icons.water_drop,
                secondIcon: Icons.track_changes_outlined,
              )
            : SizedBox(height: 0),
      ]),
    );
  }
}
