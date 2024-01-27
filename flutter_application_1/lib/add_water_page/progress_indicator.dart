import 'package:flutter/material.dart';

class MyProgressIndicator extends StatefulWidget {
  final double current;
  final double max;
  final Color color;

  MyProgressIndicator(
      {required this.current, required this.max, required this.color});

  @override
  // ignore: library_private_types_in_public_api
  _MyProgressIndicatorState createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation =
        Tween(begin: 0.0, end: _progressValue).animate(_animationController)
          ..addListener(() {
            setState(() {
              // This will call build method and update the widget with the latest value of animation.
            });
          });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MyProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.current != oldWidget.current || widget.max != oldWidget.max) {
      _progressValue = widget.current / widget.max;
      _animation = Tween(begin: _animation.value, end: _progressValue)
          .animate(_animationController);
      _animationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: _animation.value < 1 ? Colors.indigo[400] : Colors.indigo[700],
      value: _animation.value,
      backgroundColor: Color.fromARGB(255, 222, 220, 220),
      strokeWidth: 7,
    );
  }
}
