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
          "Latihan Stack dan Align",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          //background
          Column(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(flex: 1, child: Container(color: Colors.white)),
                    Flexible(flex: 1, child: Container(color: Colors.grey)),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(flex: 1, child: Container(color: Colors.grey)),
                    Flexible(flex: 1, child: Container(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          //listview
          ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "haaaaaaaaaaaaaaaaaaaaaaaaaaaahhah",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "haaaaaaaaaaaaaaaaaaaaaaaaaaaahhah",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "haaaaaaaaaaaaaaaaaaaaaaaaaaaahhah",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "haaaaaaaaaaaaaaaaaaaaaaaaaaaahhah",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "haaaaaaaaaaaaaaaaaaaaaaaaaaaahhah",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "haaaaaaaaaaaaaaaaaaaaaaaaaaaahhah",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "haaaaaaaaaaaaaaaaaaaaaaaaaaaahhah",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "haaaaaaaaaaaaaaaaaaaaaaaaaaaahhah",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ],
          ),
          //button
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(onPressed: () {}, child: Text("Klik")),
            ),
          ),
        ],
      ),
    );
  }
}
