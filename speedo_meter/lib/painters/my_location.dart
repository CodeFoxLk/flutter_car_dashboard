import 'dart:math';

import 'package:flutter/material.dart';

class MyLocationIndicator extends StatefulWidget {
  const MyLocationIndicator({Key? key, required this.size}) : super(key: key);
  final double size;
  @override
  State<MyLocationIndicator> createState() => _MyLocationIndicatorState();
}

class _MyLocationIndicatorState extends State<MyLocationIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(
        _controller,
        color: Colors.lightBlueAccent,
      ),
      child: SizedBox.square(
        dimension: widget.size,
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(
    this._animation, {
    required this.color,
  }) : super(repaint: _animation);

  final Color color;
  final Animation<double> _animation;

  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);

    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = sqrt(area * value / 4);

    final Paint paint = Paint()..strokeWidth = 2
    ..style = PaintingStyle.stroke..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}
