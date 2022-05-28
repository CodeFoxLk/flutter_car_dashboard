import 'dart:io';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/model/iso_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedo_meter/maps/map_and_navigation.dart';
import 'package:speedo_meter/painters/dash_board_painter.dart';
import 'package:speedo_meter/widgets/speedo_meter.dart';

import 'widgets/car_frame.dart';

class SpeedometerHome extends StatefulWidget {
  const SpeedometerHome({Key? key}) : super(key: key);

  @override
  _SpeedometerHomeState createState() => _SpeedometerHomeState();
}

class _SpeedometerHomeState extends State<SpeedometerHome> {
  final double _velocity = 0;
  int? _batteryLevel = 0;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // userAccelerometerEvents.listen((UserAccelerometerEvent event) {
    //   _onAccelerate(event);
    // });
    
    if (Platform.isAndroid) {
      BatteryInfoPlugin()
          .androidBatteryInfoStream
          .listen((AndroidBatteryInfo? batteryInfo) {
        _batteryLevel = batteryInfo?.batteryLevel;
        setState(() {});
      });
    } else if (Platform.isIOS) {
      BatteryInfoPlugin().iosBatteryInfo.then((IosBatteryInfo? batteryInfo) {
        _batteryLevel = batteryInfo?.batteryLevel;
        setState(() {});
      });
    }

    super.initState();
  }

  // void _onAccelerate(UserAccelerometerEvent event) {
  //   double newVelocity =
  //       sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

  //   setState(() {
  //     _velocity = newVelocity.abs();
  //   });
  // }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AspectRatio(
              aspectRatio: 100 / 40,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                    children: [
                      Expanded(
                          child: Stack(
                        children: [
                          const Positioned.fill(
                            child: MapAndNavigations(),
                          ),
                          Positioned.fill(
                              child: RepaintBoundary(
                            child: CustomPaint(
                              size: Size.fromWidth(constraints
                                  .maxHeight), // width act as height of landscape mode
                              painter: DashBoardPainter(mirror: true),
                            ),
                          ))
                        ],
                      )),
                      SizedBox.square(
                          dimension: constraints.maxHeight,
                          child: Speedometer(
                            batteryLevel: _batteryLevel ?? 0,
                            size: constraints.maxHeight,
                            speed: _velocity,
                          )),
                      Expanded(
                          child: RepaintBoundary(
                        child: CustomPaint(
                          child: const CarFrame(),
                          size: Size.fromWidth(constraints
                              .maxHeight), // width act as height of landscape mode
                          painter: DashBoardPainter(),
                        ),
                      )),
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }
}
