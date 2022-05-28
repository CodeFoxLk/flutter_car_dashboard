import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speedo_meter/painters/speedometer_painter.dart';
import 'package:speedo_meter/widgets/speedo_meter.dart';

extension SpeedometerGradiants on SpeedometerPainter{
  
  void drawSpeedGradientArc({double? speedPresentage}) { // speed
    final paintObject = Paint();
    paintObject..style = PaintingStyle.stroke
      ..strokeWidth = (size.width * innerComponentsRadiusPostion)..shader = SweepGradient(
        
      startAngle: degreeToRadians(90) + degreeFromPotionToRadians(indicatorStartPosition),
      endAngle:  degreeToRadians(90) + degreeFromPotionToRadians(indicatorStartPosition) + 2* pi,
      tileMode: TileMode.repeated,
      stops: const [
        0.2,  0.6
      ],
      colors:  [Colors.blue, Colors.red].map((element) => element.withAlpha(speedPresentage == null ? 40 : 200)).toList(),
    ).createShader(Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 2 ,
    ));
    canvas.drawArc(
        Rect.fromCircle(
          center: size.center(Offset.zero),
          radius: size.width / 2 - (size.width * innerComponentsRadiusPostion)/2,
        ),
        degreeToRadians(90) + degreeFromPotionToRadians(indicatorStartPosition), 
        degreeFromPotionToRadians((indicatorEndPosition - indicatorStartPosition) * (speedPresentage ?? 1)), 
        false,
        paintObject);
    // canvas.drawCircle(size.center(Offset.zero), size.width / 2, paintObject);
  }

  void drawInnerGradientCircle() { // wgite emboss shadow
    final paintObject = Paint();
    paintObject.shader = RadialGradient(
      stops: const [0.8, 1.0],
      colors: [
        Colors.white.withOpacity(0.001),
        Colors.white.withOpacity(0.4),
      ],
    ).createShader(Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 2,
    ));
    canvas.drawArc(
        Rect.fromCircle(
          center: size.center(Offset.zero),
          radius: size.width / 2,
        ),
        degreeToRadians(90) + degreeFromPotionToRadians(indicatorStartPosition), //radians
        degreeFromPotionToRadians(indicatorEndPosition - indicatorStartPosition), //radians
        true,
        paintObject);
    // canvas.drawCircle(size.center(Offset.zero), size.width / 2, paintObject);
  }

  void drawInnerCircle3() {
    //dark gradient from middle
   final paintObject = Paint();
    paintObject.shader =  RadialGradient(
      stops: const [0.6,0.7, 1.0],
      colors: [
        backgroundColor.withAlpha(255),
        backgroundColor.withAlpha(135),
        backgroundColor.withAlpha(0)
      ],
    ).createShader(Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width * innerComponentsRadiusPostion * 1.3,
    ));
    canvas.drawArc(
        Rect.fromCircle(
          center: size.center(Offset.zero),
          radius: size.width * innerComponentsRadiusPostion * 1.5,
        ),
        degreeToRadians(90) + degreeFromPotionToRadians(indicatorStartPosition), //radians
        degreeFromPotionToRadians(indicatorEndPosition - indicatorStartPosition), //radians
        true,
        paintObject);
  }

}