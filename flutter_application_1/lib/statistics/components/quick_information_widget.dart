import 'package:flutter/material.dart';

class QuickInformation extends StatelessWidget {
  final String? first;
  final String? second;
  final String? third;
  final String title;
  final IconData firstIcon;
  final IconData secondIcon;
  final IconData? thirdIcon;

  QuickInformation({
    required this.first,
    required this.second,
    this.third,
    required this.title,
    required this.firstIcon,
    required this.secondIcon,
    this.thirdIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 11, 49, 79),
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    firstIcon,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '$first',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(width: 16),
              Row(
                children: [
                  Icon(
                    secondIcon,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '$second',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(width: 16),
              Row(
                children: [
                  Icon(
                    thirdIcon,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '$third',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }
}
