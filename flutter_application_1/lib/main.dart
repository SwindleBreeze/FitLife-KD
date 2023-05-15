import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_water_page/add_water_page.dart';
import 'sleep_and_rest/main_page.dart';
import 'choose_exercise/display_exercises.dart';
//import 'choose_exercise/exercise_popup.dart';

import 'isar-db/isar-service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = IsarService();
  await isar.insertIfEmpty();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final isar_service = IsarService();
  // This widget is the root of your application.

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
        home: MyHomePage(),
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
  Color tmpColor = Colors.white;
  bool _isDropdownOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Water
          GestureDetector(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              height: 45,
              width: 45,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
                    );
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
                    );
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
                    );
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
}
