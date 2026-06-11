import 'package:flutter/material.dart';

class LatihanToday extends StatefulWidget {
  const LatihanToday({super.key});

  @override
  State<LatihanToday> createState() => _LatihanTodayState();
}

class _LatihanTodayState extends State<LatihanToday> {
  String message = "Belum ditekan";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anonymous Method", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(20.0), child: Text(message)),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  message = "Sudah ditekan";
                });
              },
              child: Text("Tombol"),
            ),
          ],
        ),
      ),
    );
  }
}
