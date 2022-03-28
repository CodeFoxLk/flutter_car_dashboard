import 'package:flutter/material.dart';
import 'dart:math';


class MyLocationMarker extends StatefulWidget {
  const MyLocationMarker({Key? key}) : super(key: key);

  @override
  _MyLocationMarkerState createState() => _MyLocationMarkerState();
}

class _MyLocationMarkerState extends State<MyLocationMarker>
    with TickerProviderStateMixin {
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    
    return SizedBox.square(
      dimension: 50,
      child: CustomPaint(
        painter: CirclePainter(color: Colors.blue),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter( {
    required this.color,
  });

  final Color color;


  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);

    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = sqrt(area * value / 4);

    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + 10);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate){
     if(oldDelegate == this){
       return false;
     }
     return true;
  } 
}