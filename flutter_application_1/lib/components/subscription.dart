import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/isar-db/isar-service.dart';

import '../main.dart';

class PremiumPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  late ConfettiController _controllerCenter;
  final _isar = IsarService();

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Future<void> _updateDatabase() async {
    _isar.updateUserPremium(1, true);
  }

  void _onGetPremiumClicked() {
    _controllerCenter.play();

    _updateDatabase();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Pop the current page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Premium Page'),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Premium Plan',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple, // Royal purple color
                      ),
                      textAlign: TextAlign.center, // Center the text
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Unlock exclusive features and benefits with our Premium Plan:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54, // Dark gray color
                      ),
                      textAlign: TextAlign.center, // Center the text
                    ),
                    SizedBox(height: 24),
                    BulletPoint(text: 'Water Intake Tracking'),
                    SizedBox(height: 6),
                    BulletPoint(text: 'Sleep Tracking'),
                    SizedBox(height: 6),
                    BulletPoint(
                        text:
                            'Water and Sleep Trends: Monitor consumption, analyze sleep patterns with statistics.'),
                    SizedBox(height: 6),
                    BulletPoint(
                        text:
                            'Custom Exercises: Personalized tracking and progress monitoring with custom exercises.'),
                    SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple, // Royal purple color
                            Colors.purple, // Purple color
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          _onGetPremiumClicked();
                        },
                        height: 50,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Get Premium',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
                createParticlePath: drawStar,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, right: 8),
          child: Icon(
            Icons.check_circle,
            color: Colors.amber, // Golden yellow color
            size: 20,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87, // Dark gray color
            ),
          ),
        ),
      ],
    );
  }
}
