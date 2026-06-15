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
        title: Text(
          "Latihan Image Witget",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          color: Colors.black,
          width: 200,
          height: 200,
          padding: EdgeInsets.all(5),
          child: Image(
            image: AssetImage("asset/gambar1.jpeg"),
            fit: BoxFit.cover,
            //repeat: ImageRepeat.repeat,
          ),
        ),
      ),
    );
  }
}
