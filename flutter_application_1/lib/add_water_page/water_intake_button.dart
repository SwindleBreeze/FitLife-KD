import 'package:flutter/material.dart';

class WaterIntakeButton extends StatelessWidget {
  final double amount;
  final VoidCallback onPressed;

  const WaterIntakeButton({
    Key? key,
    required this.amount,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('$amount L'),
    );
  }
}
