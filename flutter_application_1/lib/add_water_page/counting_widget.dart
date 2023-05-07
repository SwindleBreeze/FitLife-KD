import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class DecimalTween extends Tween<Decimal> {
  DecimalTween({required Decimal begin, required Decimal end})
      : super(begin: begin, end: end);

  @override
  Decimal lerp(double t) {
    return (begin! + (end! - begin!) * Decimal.parse(t.toStringAsFixed(2)));
  }
}

class CountingWidget extends StatefulWidget {
  final double count;

  const CountingWidget({Key? key, required this.count}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CountingWidgetState createState() => _CountingWidgetState();
}

class _CountingWidgetState extends State<CountingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CountingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.count != widget.count) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Decimal>(
      tween: DecimalTween(
        begin: Decimal.parse((widget.count - 0.01).toStringAsFixed(2)),
        end: Decimal.parse(widget.count.toStringAsFixed(2)),
      ),
      duration: const Duration(milliseconds: 500),
      builder: (context, Decimal value, child) {
        return Text(
          '${value.toStringAsFixed(2)} L',
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
    );
  }
}
