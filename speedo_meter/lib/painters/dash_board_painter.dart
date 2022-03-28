 import 'package:flutter/material.dart';

import '../speedo_meter.dart';

class DashBoardPainter extends CustomPainter {

    final bool mirror;

  DashBoardPainter({this.mirror = false});

    @override
    void paint(Canvas canvas, Size size) {
      Paint paint = Paint();
      Path path = Path();  
      var rect = Offset.zero & size;

  
      //paint.color = const Color.fromARGB(255, 132, 129, 148);
      paint.shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        
        colors: [
        Color.fromARGB(255, 141, 141, 141),
        Color.fromARGB(255, 197, 197, 197),
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 148, 136, 153),
        Color.fromARGB(255, 179, 179, 179),
        Color.fromARGB(255, 95, 95, 95),
      ],).createShader(rect);

      path = Path();
      path.lineTo(size.width * 0.54, size.height);
      path.cubicTo(size.width * 0.72, size.height, size.width * 0.84, size.height, size.width * 0.91, size.height * 0.81);
      path.cubicTo(size.width * 0.94, size.height * 0.72, size.width, size.height * 0.49, size.width, size.height * 0.4);
      path.cubicTo(size.width, size.height * 0.31, size.width * 0.9, size.height / 5, size.width * 0.85, size.height * 0.14);
      path.cubicTo(size.width * 0.84, size.height * 0.12, size.width * 0.75, size.height * 0.01, size.width * 0.74, 0);
      path.cubicTo(size.width * 0.73, 0, size.width * 0.73, 0, size.width * 0.73, 0);
      path.cubicTo(size.width * 0.73, size.height * 0.01, size.width * 0.84, size.height * 0.18, size.width * 0.86, size.height / 5);
      path.cubicTo(size.width, size.height * 0.4, size.width * 0.96, size.height * 0.48, size.width * 0.89, size.height * 0.72);
      path.cubicTo(size.width * 0.87, size.height * 0.81, size.width * 0.84, size.height * 0.88, size.width * 0.75, size.height * 0.93);
      path.cubicTo(size.width * 0.71, size.height * 0.95, size.width * 0.63, size.height * 0.96, size.width * 0.54, size.height * 0.96);
      path.cubicTo(size.width * 0.54, size.height * 0.96, 0, size.height, 0, size.height);
      path.cubicTo(0, size.height, size.width * 0.54, size.height, size.width * 0.54, size.height);
      path.cubicTo(size.width * 0.54, size.height, size.width * 0.54, size.height, size.width * 0.54, size.height);
      if(mirror){
        canvas.scale(-1, 1);
        canvas.translate(-size.width, 0);
      }
      canvas.drawPath(path, paint);
    }
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return false;
    }
  }




  class DashBoarMapShadowdBlur extends CustomPainter {

    final bool innerBlur;

  DashBoarMapShadowdBlur({this.innerBlur = false});

    @override
    void paint(Canvas canvas, Size size) {
      
      Path path = Path();

      final strokeWidth = innerBlur ? size.width * 0.1 : size.width * 0.3;
      final blurAmoint = innerBlur ? 5.0 : 20.0;
  
      Paint shadowPaint = Paint()
    ..color = backgroundColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..maskFilter =  MaskFilter.blur(BlurStyle.normal, blurAmoint);
     
      path = getPath(size);
      canvas.drawPath(path, shadowPaint);
    }
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return false;
    }
  }

  class DashBoardMapClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = getPath(size);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Path getPath( Size size){
   Path path = Path();
   path = Path();
      path.lineTo(size.width * 0.94, size.height * 0.07);
      path.cubicTo(size.width * 0.97, size.height * 0.18, size.width, size.height, size.width, size.height);
      path.cubicTo(size.width, size.height, size.width * 0.34, size.height * 0.96, size.width * 0.34, size.height * 0.96);
      path.cubicTo(size.width * 0.11, size.height * 0.95, size.width * 0.1, size.height * 0.79, size.width * 0.03, size.height * 0.6);
      path.cubicTo(size.width * 0.01, size.height * 0.51, 0, size.height * 0.51, 0, size.height * 0.39);
      path.cubicTo(size.width * 0.02, size.height * 0.34, size.width * 0.03, size.height * 0.3, size.width * 0.07, size.height / 4);
      path.cubicTo(size.width * 0.07, size.height / 4, size.width * 0.24, size.height * 0.02, size.width * 0.24, size.height * 0.02);
      path.cubicTo(size.width * 0.52, -0.02, size.width * 0.92, size.height * 0.01, size.width * 0.94, size.height * 0.07);
      path.cubicTo(size.width * 0.94, size.height * 0.07, size.width * 0.94, size.height * 0.07, size.width * 0.94, size.height * 0.07);
  return path;
}