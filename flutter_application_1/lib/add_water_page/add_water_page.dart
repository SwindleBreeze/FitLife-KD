// Libraries and packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/statistics/wasser_intake_statistics.dart';

// My widgets
import '../components/subscription.dart';
import '../models/user.dart';
import 'progress_indicator.dart';
import 'water_intake_button.dart';
import 'counting_widget.dart';

// Models
import '../models/water_intake.dart';

// Isar service
import '../isar-db/isar-service.dart';

class AddWaterPage extends StatefulWidget {
  const AddWaterPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddWaterPageState createState() => _AddWaterPageState();
}

class _AddWaterPageState extends State<AddWaterPage> {
  final isarService = IsarService();

  double waterIntake = 0; // The amount of water added
  double maxWaterIntake = 3; // The maximum amount of water intake in liters
  bool _sliderNeeded = false;
  Color _color = Colors.purple;

  @override
  void initState() {
    _checkPremiumAccess();
    _loadWaterIntake();
    super.initState();
  }

  Future<void> _checkPremiumAccess() async {
    bool isPremium = await _isUserPremium();
    if (!isPremium) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Pop the current page
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PremiumPage()),
      );
    }
  }

  Future<bool> _isUserPremium() async {
    User? user = await isarService.getUserById(1);

    if (user?.premium == false) {
      return false;
    }

    return true;
  }

  Future<void> _loadWaterIntake() async {
    DateTime currentDate = DateTime.now();
    DateTime dateOnly =
        DateTime(currentDate.year, currentDate.month, currentDate.day);

    // Retrieve the water intake entry for the current date
    WaterIntake? waterIntakeEntry =
        await isarService.getWaterIntakeByDate(dateOnly);

    print(dateOnly);

    if (waterIntakeEntry != null) {
      // Water intake entry found, update the waterIntake value
      if (mounted) {
        setState(() {
          waterIntake = waterIntakeEntry.waterIntake;
          maxWaterIntake = waterIntakeEntry.maxWaterIntake;
        });
      }
    }
  }

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
        backgroundColor: Colors.deepPurple,
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
                  color: Colors.deepPurple,
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
                  onPressed: () async {
                    setState(() {
                      waterIntake += 0.2;
                    });

                    DateTime currentDate = DateTime.now();
                    currentDate = DateTime(
                        currentDate.year, currentDate.month, currentDate.day);

                    WaterIntake newWaterIntake = WaterIntake(
                      date: currentDate,
                      waterIntake: waterIntake,
                      maxWaterIntake: maxWaterIntake,
                    );

                    // Check if water intake entry already exists for the current date
                    WaterIntake? existingIntake =
                        await isarService.getWaterIntakeByDate(currentDate);
                    if (existingIntake != null) {
                      // Update the existing entry
                      existingIntake.waterIntake = newWaterIntake.waterIntake;
                      existingIntake.maxWaterIntake =
                          newWaterIntake.maxWaterIntake;
                      await isarService.updateWaterIntake(existingIntake);
                    } else {
                      // Add a new entry
                      await isarService.addWaterIntake(newWaterIntake);
                    }
                  },
                ),
                WaterIntakeButton(
                  amount: 0.25,
                  onPressed: () async {
                    setState(() {
                      waterIntake += 0.25;
                    });

                    DateTime currentDate = DateTime.now();
                    currentDate = DateTime(
                        currentDate.year, currentDate.month, currentDate.day);

                    WaterIntake newWaterIntake = WaterIntake(
                      date: currentDate,
                      waterIntake: waterIntake,
                      maxWaterIntake: maxWaterIntake,
                    );

                    // Check if water intake entry already exists for the current date
                    WaterIntake? existingIntake =
                        await isarService.getWaterIntakeByDate(currentDate);
                    if (existingIntake != null) {
                      // Update the existing entry
                      existingIntake.waterIntake = newWaterIntake.waterIntake;
                      existingIntake.maxWaterIntake =
                          newWaterIntake.maxWaterIntake;
                      await isarService.updateWaterIntake(existingIntake);
                    } else {
                      // Add a new entry
                      await isarService.addWaterIntake(newWaterIntake);
                    }
                  },
                ),
                WaterIntakeButton(
                  amount: 0.5,
                  onPressed: () async {
                    setState(() {
                      waterIntake += 0.5;
                    });

                    DateTime currentDate = DateTime.now();
                    currentDate = DateTime(
                        currentDate.year, currentDate.month, currentDate.day);

                    WaterIntake newWaterIntake = WaterIntake(
                      date: currentDate,
                      waterIntake: waterIntake,
                      maxWaterIntake: maxWaterIntake,
                    );

                    // Check if water intake entry already exists for the current date
                    WaterIntake? existingIntake =
                        await isarService.getWaterIntakeByDate(currentDate);
                    if (existingIntake != null) {
                      // Update the existing entry
                      existingIntake.waterIntake = newWaterIntake.waterIntake;
                      existingIntake.maxWaterIntake =
                          newWaterIntake.maxWaterIntake;
                      await isarService.updateWaterIntake(existingIntake);
                    } else {
                      // Add a new entry
                      await isarService.addWaterIntake(newWaterIntake);
                    }
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
                  onPressed: () async {
                    setState(() {
                      waterIntake += 0.75;
                    });

                    DateTime currentDate = DateTime.now();
                    currentDate = DateTime(
                        currentDate.year, currentDate.month, currentDate.day);

                    WaterIntake newWaterIntake = WaterIntake(
                      date: currentDate,
                      waterIntake: waterIntake,
                      maxWaterIntake: maxWaterIntake,
                    );

                    // Check if water intake entry already exists for the current date
                    WaterIntake? existingIntake =
                        await isarService.getWaterIntakeByDate(currentDate);
                    if (existingIntake != null) {
                      // Update the existing entry
                      existingIntake.waterIntake = newWaterIntake.waterIntake;
                      existingIntake.maxWaterIntake =
                          newWaterIntake.maxWaterIntake;
                      await isarService.updateWaterIntake(existingIntake);
                    } else {
                      // Add a new entry
                      await isarService.addWaterIntake(newWaterIntake);
                    }
                  },
                ),
                WaterIntakeButton(
                  amount: 1.0,
                  onPressed: () async {
                    setState(() {
                      waterIntake += 1.0;
                    });

                    DateTime currentDate = DateTime.now();
                    currentDate = DateTime(
                        currentDate.year, currentDate.month, currentDate.day);

                    WaterIntake newWaterIntake = WaterIntake(
                      date: currentDate,
                      waterIntake: waterIntake,
                      maxWaterIntake: maxWaterIntake,
                    );

                    print(newWaterIntake.date);

                    // Check if water intake entry already exists for the current date
                    WaterIntake? existingIntake =
                        await isarService.getWaterIntakeByDate(currentDate);
                    if (existingIntake != null) {
                      // Update the existing entry
                      existingIntake.waterIntake = newWaterIntake.waterIntake;
                      existingIntake.maxWaterIntake =
                          newWaterIntake.maxWaterIntake;
                      await isarService.updateWaterIntake(existingIntake);
                    } else {
                      // Add a new entry
                      await isarService.addWaterIntake(newWaterIntake);
                    }
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
                        onChanged: (selectedValue) async {
                          setState(() {
                            maxWaterIntake = selectedValue;
                          });

                          // Check if any water intake entry exists in the database
                          List<WaterIntake> waterIntakes =
                              await isarService.getWaterIntakes();
                          if (waterIntakes.isNotEmpty) {
                            // Retrieve the last water intake entry
                            WaterIntake lastIntake = waterIntakes.last;
                            // Update the maxWaterIntake value of the last entry
                            lastIntake.maxWaterIntake = maxWaterIntake;
                            // Update the entry in the database
                            await isarService.updateWaterIntake(lastIntake);
                          } else {
                            // No existing entries, add a new entry for the current maxWaterIntake value
                            DateTime currentDate = DateTime.now();
                            currentDate = DateTime(currentDate.year,
                                currentDate.month, currentDate.day);
                            WaterIntake newWaterIntake = WaterIntake(
                              date: currentDate,
                              waterIntake: waterIntake,
                              maxWaterIntake: maxWaterIntake,
                            );
                            await isarService.addWaterIntake(newWaterIntake);
                          }
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
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.analytics_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WaterStatsPage()),
          );
        },
      ),
    );
  }
}
