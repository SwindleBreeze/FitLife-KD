// Libraries and packages
import 'package:flutter/material.dart';
import 'sleep_duration_picker.dart';

class MySleepPage extends StatefulWidget {
  const MySleepPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MySleepPageState createState() => _MySleepPageState();
}

class _MySleepPageState extends State<MySleepPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            'SLEEP TRACKER',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 4.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: SetAlarm());
  }
}
