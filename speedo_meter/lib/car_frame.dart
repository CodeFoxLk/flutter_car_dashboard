import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CarFrame extends StatefulWidget {
  const CarFrame({
    Key? key,
  }) : super(key: key);

  @override
  State<CarFrame> createState() => _CarFrameState();
}

class _CarFrameState extends State<CarFrame>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ColorTween _colorTween;
  late Animation<Color?> _colorTweenAnimation;
  late Color beginColor;
  late Color endColor;

  @override
  void initState() {
    beginColor = Colors.lightBlueAccent.withOpacity(0.5);
    endColor = Colors.redAccent.withOpacity(0.3);
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _colorTween = ColorTween(begin: beginColor, end: endColor);
    _colorTweenAnimation = _colorTween.animate(_animationController);
    _animationController.repeat(reverse: true);
    super.initState();
  }

  bool disposed = false;

  

  @override
  void dispose() {
    _animationController.dispose();
    disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: constraints.maxHeight * 0.15,
                horizontal: constraints.maxHeight * 0.1),
            child: Center(
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/carbody.svg',
                    color: Colors.blue,
                  ),
                  SvgPicture.asset(
                    'assets/car.svg',
                    color: Colors.blue.withOpacity(0.4),
                  ),
                  SvgPicture.asset(
                    'assets/axle.svg',
                    color: _colorTweenAnimation.value,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
