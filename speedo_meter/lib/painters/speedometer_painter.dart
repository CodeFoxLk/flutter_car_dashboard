
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speedo_meter/painters/fuels_and_range_painer.dart';
import 'package:speedo_meter/painters/speedometer_gradients.dart';
import 'package:speedo_meter/widgets/speedo_meter.dart';

class SpeedometerPainter extends CustomPainter {
  
  SpeedometerPainter({
    this.speed = 20.0,
    required this.batteryLevel,
  });

  final double speed;
  final int batteryLevel;

  late Size size;
  late Canvas canvas;
  late Offset _center;

  @override
  void paint(Canvas canvas, Size size) {
    _init(canvas, size);
    drawSpeedGradientArc(speedPresentage: speed / topSpeed);
    drawInnerCircle3();
    drawSpeedGradientArc();
    _drawOuterCircle();
    drawInnerGradientCircle();
    _drawInnerCircle();
    _drawMarkers();
    fuelAndRangeRange(remainingPresentage: batteryLevel);
    _drawIndicatorNeedle(
        indicatorStartPosition +
            (speed / topSpeed) *
                (indicatorEndPosition -
                    indicatorStartPosition), // moving potion
        componentsPrimaryColor,
        size.width / 70);
    // _drawSpeedIndicators(size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if(oldDelegate != this) {
      return true;
    }return false;
  }

  void _init(Canvas canvas, Size size) {
    this.canvas = canvas;
    this.size = size;
    _center = size.center(Offset.zero);
  }

  void _drawOuterCircle() {
    Paint paintObject = Paint();
    paintObject
      ..color = componentsPrimaryColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paintObject);
  }

  void _drawInnerCircle() {
    Paint paintObject = Paint();
    paintObject
      ..color = componentsPrimaryColor.withOpacity(0.5)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(size.center(Offset.zero),
        size.width * innerComponentsRadiusPostion, paintObject);
  }

  int printedMarkersCount = 0;

  void _drawMarkers() {
    // marks count = (indicatorEndPosition - indicatorStartPosition)/x
    // if marks count == top speed. then x = (indicatorEndPosition - indicatorStartPosition)/ top speed

    //gap between two Markers , 
    //double splitGap = (indicatorEndPosition - indicatorStartPosition) / topSpeed; 
    // gaps == topSpeed, so there will be {topSpeed value} Markers wich is 0,1,2 ...... to speed
    
    double splitGap = (indicatorEndPosition - indicatorStartPosition) / topSpeed; 
    
    Paint paintObject = Paint();
    paintObject.style = PaintingStyle.fill;
    
    for (double relativeRotation = indicatorStartPosition;  relativeRotation <= indicatorEndPosition; relativeRotation += splitGap) {
      relativeRotation = double.parse((relativeRotation).toStringAsFixed(4)); // avoid => 0.7500000000000003
      bool isBigMarker = printedMarkersCount % bigMarkerFinder == 0;
      printedMarkersCount = printedMarkersCount + 1;
      _drawRotated(relativeRotation, () => _drawMarker(isBigMarker));
    }
  }

  void _drawRotated(double angle, Function drawFunction) {
    canvas.save();
    canvas.translate(_center.dx, _center.dy);
    //0.00 position is bottom center of canvas. so indicators, markers draw statrting from there 6 of clock
    canvas.rotate(angle *
        pi *
        2); // canvas.rotate(angle *  360 * (pi/180)); // angle to radians
    canvas.translate(-_center.dx, -_center.dy);
    drawFunction();
    canvas.restore();
  }

  void _drawMarker(bool isBigMarker) {
    Paint paintObject = Paint();
    paintObject
      ..color = componentsPrimaryColor
      ..shader = null;
    Path markerPath = Path()
      ..addRect(Rect.fromLTRB(
        _center.dx - size.width / (isBigMarker ? 200 : 300),
        _center.dy + size.height / (isBigMarker ? 2.15 : 2.08),
        _center.dx + size.width / (isBigMarker ? 200 : 300),
        _center.dy + (size.height / 2),
      ));
    canvas.drawPath(markerPath, paintObject);
  }

  void _drawIndicatorNeedle(double rotation, Color color, double width) {
    Paint paintObject = Paint();
    paintObject
      ..style = PaintingStyle.fill
      ..color = color;

    Path needlePath = Path()
      ..moveTo(_center.dx - width,
          _center.dy + size.width * innerComponentsRadiusPostion)
      ..lineTo(_center.dx + width,
          _center.dy + size.width * innerComponentsRadiusPostion)
      ..lineTo(_center.dx, _center.dy + size.width / 2.2)
      ..lineTo(_center.dx, _center.dy + size.width / 2.2);

    _drawRotated(rotation, () {
      canvas.drawPath(needlePath, paintObject);
    });
  }
}
