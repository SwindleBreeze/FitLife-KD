import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_water_page/add_water_page.dart';
import 'sleep_and_rest/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter application 1',
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
    );
  }
}
