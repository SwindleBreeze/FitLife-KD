import 'package:flutter/material.dart';

class begin_exercise_button extends StatelessWidget {
  final String exercise;
  final VoidCallback onPressed;

  const begin_exercise_button({
    Key? key,
    required this.exercise,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(exercise),
    );
  }
}
