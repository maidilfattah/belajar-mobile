import 'package:flutter/material.dart';

class LatihanToday extends StatefulWidget {
  const LatihanToday({super.key});

  @override
  State<LatihanToday> createState() => _LatihanTodayState();
}

class _LatihanTodayState extends State<LatihanToday> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fleksibel Widget", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Flexible(flex: 1, child: Container(color: Colors.red)),
                Flexible(flex: 1, child: Container(color: Colors.yellow)),
                Flexible(flex: 1, child: Container(color: Colors.green)),
              ],
            ),
          ),

          Flexible(flex: 2, child: Container(color: Colors.blue)),

          Flexible(flex: 1, child: Container(color: Colors.purple)),
        ],
      ),
    );
  }
}
