import 'package:time_duration_picker/time_duration_picker.dart';
import 'package:flutter/material.dart';

class SetAlarm extends StatefulWidget {
  const SetAlarm({Key? key}) : super(key: key);

  @override
  State<SetAlarm> createState() => _SetAlarmState();
}

class _SetAlarmState extends State<SetAlarm> {
  String alarmTime = "12:00 PM";
  String bedTime = "12:00 AM";
  String sleepDuration = "12 hr 00 min";

  @override
  Widget build(BuildContext context) {
    double smallerMarginRatio = 0.025;

    double horizontalPadding = 0.08;

    double verticalPadding = 0.05;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * horizontalPadding,
            vertical: size.height * verticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * smallerMarginRatio * 1.1),
            TimeDurationPicker(
              diameter: size.width * 0.75,
              icon1Data: Icons.notifications_none,
              icon2Data: Icons.bed,
              knobDecoration:
                  const BoxDecoration(color: Color.fromRGBO(167, 153, 240, 1)),
              clockDecoration: const BoxDecoration(
                  gradient: RadialGradient(colors: [
                Color.fromRGBO(167, 153, 240, 1),
                Colors.white
              ])),
              knobBackgroundDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(218, 224, 238, 1),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.white,
                    Color.fromRGBO(218, 224, 238, 1),
                  ],
                  stops: [0.1, 1],
                ),
              ),
              onIcon1RotatedCallback: (value) {
                setState(() {
                  alarmTime = value;
                });
              },
              onIcon2RotatedCallback: (value) {
                setState(() {
                  bedTime = value;
                });
              },
              setDurationCallback: (value) {
                setState(() {
                  sleepDuration = value;
                });
              },
            ),
            SizedBox(height: size.height * 2 * smallerMarginRatio * 0.75),
            Container(
              alignment: Alignment.center,
              width: size.width,
                child: Text(
                  sleepDuration,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Color.fromRGBO(88, 97, 130, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
            SizedBox(height: size.height * 0.85 * smallerMarginRatio),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AlarmDescription(
                    iconData: Icons.bed,
                    title: "Bedtime",
                    width: size.width * 0.4,
                    time: bedTime),
                AlarmDescription(
                    iconData: Icons.notifications_none,
                    title: "Wake Up",
                    width: size.width * 0.4,
                    time: alarmTime)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AlarmDescription extends StatefulWidget {
  final IconData iconData;
  final String title;
  final String time;
  final double width;
  const AlarmDescription(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.width,
      required this.time})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AlarmDescriptionState createState() => _AlarmDescriptionState();
}

class _AlarmDescriptionState extends State<AlarmDescription> {
  double horizontalPadding = 0.15;
  double verticalPadding = 0.1;
  double aspectRatio = 0.8;
  late double height;

  @override
  void initState() {
    super.initState();
    height = widget.width / aspectRatio;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: height,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 242, 245),
          borderRadius: BorderRadius.circular(widget.width * 0.25)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * verticalPadding,
            horizontal: widget.width * horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              widget.iconData,
              color: const Color.fromRGBO(167, 153, 240, 1),
              size: height * 0.3,
            ),
            SizedBox(
              width: widget.width * (1 - 2 * horizontalPadding) * 0.63,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      color: Color.fromRGBO(
                        54,
                        61,
                        86,
                        1,
                      ),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: widget.width * (1 - 2 * horizontalPadding),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  widget.time,
                  style: const TextStyle(
                    color: Color.fromRGBO(
                      54,
                      61,
                      86,
                      1,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
