import 'package:flutter/material.dart';
import 'package:speedo_meter/speedo_meter.dart';
import 'package:speedo_meter/painters/speedometer_painter.dart';

const fuelandRangIndicatorActiveColor = Color.fromARGB(255, 33, 205, 243);
const fuelandRangIndicatorDrainedColor2 = Color.fromARGB(255, 173, 255, 9);
const fuelandRangIndicatorDrainedColor = Color.fromARGB(255, 243, 33, 33);
const fuelandRangIndicatorInactiveColor = Color.fromARGB(98, 140, 140, 140);

extension FuelAndRange on SpeedometerPainter {
  void fuelAndRangeRange({int remainingPresentage = 100}) {
    assert(remainingPresentage <= 100);
 
    final double gapBetweenWithIndicators = degreeToRadians(10);
    final double startPosition = degreeFromPotionToRadians(indicatorEndPosition) + gapBetweenWithIndicators - degreeToRadians(270);
    final double sweepAngle = degreeFromPotionToRadians(1 - (indicatorEndPosition - indicatorStartPosition)) - gapBetweenWithIndicators * 2;

    final double batteryIndicarotHolderLengthInRadians = sweepAngle;
    final double gapsLengthForIndicators = batteryIndicarotHolderLengthInRadians * 0.25;

    const int indicatorsCount = 20;
    final double singleIndicatorLengthInRadians = (batteryIndicarotHolderLengthInRadians - gapsLengthForIndicators) / indicatorsCount;
    final double singleGapLengthInRadians = gapsLengthForIndicators / (indicatorsCount - 1); // if indicators count 10 -> gaps -> 9


    final double _batteryDrainedPresentage = 1 - remainingPresentage/100;
    late Color? _activeColor =  getBatteryIndicatorColor(batteryLevel: remainingPresentage);

    Paint paintObject = Paint();
    paintObject
      ..color = _activeColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    //draw holder
    canvas.drawArc(
        Rect.fromCircle(
          center: size.center(Offset.zero),
          radius: size.width / 2.1,
        ),
        startPosition, //arc draw start point is 3 on clock // speed indicators draw start from bottom of circle // need to find indicators end position and how many degrees are have from the arc start position
        sweepAngle, //  how many degrees should sweep to meet the indicators start position
        false,
        paintObject);

    Paint indicatorsPaintObject = Paint();
    indicatorsPaintObject
      ..color = fuelandRangIndicatorActiveColor
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

   
    //draw indicators
    var startPositionIndicator = startPosition;
    
    for (var i = 0; i < indicatorsCount; i++) {
     
      final endPositionIndicator = singleIndicatorLengthInRadians;

      if (i < (indicatorsCount  * _batteryDrainedPresentage).truncate()) {
        indicatorsPaintObject.color = fuelandRangIndicatorInactiveColor;
      } else {
        indicatorsPaintObject.color = _activeColor;
      }

      canvas.drawArc(
          Rect.fromCircle(
            center: size.center(Offset.zero),
            radius: size.width / 2.21,
          ),
          startPositionIndicator, //arc draw start point is 3 on clock // indicators draw start from bottom of circle // need to find indicators end position and how meny degrees have from the arc start position
          endPositionIndicator, // show many degrees should sweep to meet the indicators start position
          false,
          indicatorsPaintObject);

      startPositionIndicator +=
          (endPositionIndicator + singleGapLengthInRadians);
    }
  }
}
