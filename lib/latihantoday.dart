import 'dart:math';
import 'package:flutter/material.dart';

class LatihanToday extends StatefulWidget {
  const LatihanToday({super.key});

  @override
  State<LatihanToday> createState() => _LatihanTodayState();
}

class _LatihanTodayState extends State<LatihanToday> {
  final Random _random = Random();

  // 1. Define state variables with initial values
  Color _color = Colors.blue;
  double _width = 100.0;
  double _height = 100.0;

  // 2. Create a method to randomize the values
  void _randomizeContainer() {
    setState(() {
      _color = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
      _width = 50.0 + _random.nextInt(101);
      _height = 50.0 + _random.nextInt(101);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Latihan AnimationContainer",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: GestureDetector(
        onTap: _randomizeContainer, // 3. Trigger randomization on tap
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves
                .fastOutSlowIn, // Optional: Makes the animation look smoother
            color: _color,
            width: _width,
            height: _height,
          ),
        ),
      ),
    );
  }
}
