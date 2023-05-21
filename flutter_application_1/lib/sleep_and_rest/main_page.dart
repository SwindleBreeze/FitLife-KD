// Libraries and packages
import 'package:flutter/material.dart';
import 'package:flutter_application_1/isar-db/isar-service.dart';
import '../components/subscription.dart';
import '../models/user.dart';
import '../statistics/sleep_statistics.dart';
import 'sleep_duration_picker.dart';

class MySleepPage extends StatefulWidget {
  const MySleepPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MySleepPageState createState() => _MySleepPageState();
}

class _MySleepPageState extends State<MySleepPage> {
  final _isar = IsarService();

  @override
  void initState() {
    _checkPremiumAccess();
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
    User? user = await _isar.getUserById(1);

    if (user?.premium == false) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    if(!mounted) return SizedBox();

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
      body: SetAlarm(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.analytics_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SleepStatsPage()),
          );
        },
      ),
    );
  }
}
