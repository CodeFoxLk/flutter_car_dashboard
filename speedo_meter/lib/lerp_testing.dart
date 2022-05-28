import 'dart:math';

import 'package:flutter/material.dart';

class LerpTesting extends StatefulWidget {
  LerpTesting({Key? key}) : super(key: key);

  @override
  State<LerpTesting> createState() => _LerpTestingState();
}

class _LerpTestingState extends State<LerpTesting> {

  List<double> values = [0,1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
                builder: (BuildContext context, Object? value, Widget? child) { 
                return Text(value.toString());
               },
               curve: Curves.decelerate,
              duration: const Duration(milliseconds: 100),
              tween: Tween(
                begin: values[values.length - 1],
                end: values.last
              ),
              ),
            ElevatedButton(onPressed: (){
              setState(() {
                values.add(Random().nextDouble() * 100);
              });
            }, child: const Text("Tap here"))
          ],
        )
      ),
    );
  }
}