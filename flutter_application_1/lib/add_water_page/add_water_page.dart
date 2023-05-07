// Libraries and packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// My files
import 'progress_indicator.dart';
import 'water_intake_button.dart';
import 'counting_widget.dart';

class AddWaterPage extends StatefulWidget {
  const AddWaterPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddWaterPageState createState() => _AddWaterPageState();
}

class _AddWaterPageState extends State<AddWaterPage> {
  double waterIntake = 0; // The amount of water added
  double maxWaterIntake = 3; // The maximum amount of water intake in liters
  bool _sliderNeeded = false;
  Color _color = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADD WATER',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 4.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CountingWidget(count: waterIntake),
            SizedBox(height: 25),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: MyProgressIndicator(
                      current: waterIntake, max: maxWaterIntake, color: _color),
                ),
                Icon(
                  Icons.water_drop_outlined,
                  color: Colors.blue,
                  size: 110.0,
                ),
              ],
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WaterIntakeButton(
                  amount: 0.2,
                  onPressed: () {
                    setState(() {
                      waterIntake += 0.2;
                    });
                  },
                ),
                WaterIntakeButton(
                  amount: 0.25,
                  onPressed: () {
                    setState(() {
                      waterIntake += 0.25;
                    });
                  },
                ),
                WaterIntakeButton(
                  amount: 0.5,
                  onPressed: () {
                    setState(() {
                      waterIntake += 0.5;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WaterIntakeButton(
                  amount: 0.75,
                  onPressed: () {
                    setState(() {
                      waterIntake += 0.75;
                    });
                  },
                ),
                WaterIntakeButton(
                  amount: 1.0,
                  onPressed: () {
                    setState(() {
                      waterIntake += 1.0;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 75),
                  ElevatedButton(
                    onPressed: () {
                      // Change the settings for water intake
                      setState(() {
                        _sliderNeeded = !_sliderNeeded;
                      });
                    },
                    child: Text("Goal intake: $maxWaterIntake"),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 40,
                    child: Visibility(
                      visible: _sliderNeeded,
                      child: CupertinoSlider(
                        value: maxWaterIntake,
                        min: 1,
                        max: 5,
                        divisions: 40,
                        onChanged: (selectedValue) {
                          setState(() {
                            maxWaterIntake = selectedValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.analytics_outlined),
        onPressed: () {
          // Go to Water Intake Statistics and Trends
        },
      ),
    );
  }
}
