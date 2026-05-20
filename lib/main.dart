import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_application_1/FarmApp1.dart';
//import 'package:flutter_application_1/FarmApp2.dart';
import 'package:flutter_application_1/latihancrud.dart';

void main() {
  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  //runApp(MyApp()); untuk full layar di hp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: CrudScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('halo bang ini'),
      ),
      body: Center(
        child: Text(
          '$_counter',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,

        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'ini menu 1',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'ini menu 2',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'ini menu 3',
          ),
        ],
      ),
    );
  }
}
