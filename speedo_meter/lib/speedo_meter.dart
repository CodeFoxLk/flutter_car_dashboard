import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:speedo_meter/painters/fuels_and_range_painer.dart';
import 'package:speedo_meter/painters/speedometer_painter.dart';

import 'providers/geo_location_provider.dart';

const topSpeed = 40;
const indicatorStartPosition = 0.15; // 360 * 0.15  // 0.00 position is bottom center of canvas. soindicators, markers draw statrting from there 6 of clock
const indicatorEndPosition = 0.85; // 360 * 0.85
const exponent = 3;
const bigMarkerFinder = 5; // Markers splitting count   // indicatorEndPosition - indicatorStartPosition /  bigMarkerFinder => shoud be integer
const innerComponentsRadiusPostion = 0.25;
const Color componentsPrimaryColor = Colors.white;
const Color backgroundColor = Color.fromARGB(255, 11, 11, 12);
const maxRangeInKm = 500;

class Speedometer extends StatelessWidget {
  final double speed;
  final int batteryLevel;
  final double size;

  const Speedometer(
      {Key? key, required this.speed, this.size = 300, this.batteryLevel = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final String speed = this.speed.toStringAsFixed(2);  -->  Accelerometer speed
    final String speed = context.watch<GeoLocationProvider>().speed;
    return RepaintBoundary(
      child: CustomPaint(
          isComplex: true,
          child: SizedBox.square(
            dimension: size,
            child: DefaultTextStyle(
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox.square(
                    dimension: size * innerComponentsRadiusPostion * 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                                children: [
                              TextSpan(
                                  text: speed.split('.')[0],
                                  style: TextStyle(fontSize: size * 0.2)),
                              TextSpan(
                                  text: '.' + speed.split('.')[1],
                                  style: TextStyle(fontSize: size * 0.05)),
                            ])),
                        Text("km/h", style: TextStyle(fontSize: size * 0.06)),
                      ],
                    ),
                  ),
                  Expanded(
                      child: DefaultTextStyle(
                    style: TextStyle(
                        color: getBatteryIndicatorColor(
                            batteryLevel: batteryLevel)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/distance.svg',
                              color: getBatteryIndicatorColor(
                                  batteryLevel: batteryLevel),
                              width: size * 0.05,
                            ),
                            Text('  ${batteryLevel / 100 * maxRangeInKm}km',
                                style: TextStyle(fontSize: size * 0.05))
                          ],
                        ),
                        SizedBox(height: size * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/battery.svg',
                              color: getBatteryIndicatorColor(
                                  batteryLevel: batteryLevel),
                              width: size * 0.05,
                            ),
                            Text('  $batteryLevel%',
                                style: TextStyle(fontSize: size * 0.05))
                          ],
                        ),
                        SizedBox(height: size * 0.05)
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          painter: SpeedometerPainter(
              speed: double.parse(speed), batteryLevel: batteryLevel),
          size: Size(size, size)),
    );
  }
}

double degreeToRadians(double degree) {
  return degree * pi / 180;
}

double degreeFromPotionToRadians(double degree) {
  return degree * (pi / 180) * 360;
}

Color getBatteryIndicatorColor({required int batteryLevel}) {
  late Color? _activeColor = fuelandRangIndicatorActiveColor;

  final batteryDrainedPresentage = 1 - batteryLevel / 100;

  if (batteryDrainedPresentage < 0.6) {
    _activeColor = Color.lerp(fuelandRangIndicatorActiveColor,
        fuelandRangIndicatorDrainedColor2, batteryDrainedPresentage);
  } else if (batteryDrainedPresentage < 0.8) {
    _activeColor = Colors.orange;
  } else {
    _activeColor = Colors.red;
  }
  return _activeColor!;
}
